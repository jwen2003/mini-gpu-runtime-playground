# From Matrix Multiplication to GPU Kernels: Benchmark Methodology

[简体中文](benchmark_methodology_zh-CN.md) | [English](benchmark_methodology_en.md)

## 1. Purpose

Define correctness and performance protocols that make comparisons across implementations and dimensions consistent, interpretable, and reproducible. The aim is not to eliminate all system noise.

## 2. Build environment

Recorded local environment:

- AMD Ryzen 7 7730U, 8 cores / 16 threads.
- Per-core L1D: 32 KiB, 8-way, 64 sets, 64-byte lines.
- Per-core L2: 512 KiB, 8-way.
- Shared L3: 16 MiB, 16-way.
- GCC 15.2, Release, `-O3 -DNDEBUG`.
- WSL2 Ubuntu.

Record the platform and build environment with performance conclusions. Do not assume the same results on other CPUs, compilers, or operating systems.

## 3. Correctness baseline

### 3.1 Oracle

`matmul_reference` uses the same FP32 inputs and outputs, double intermediate accumulation, and final conversion to float. This reduces oracle accumulation error but provides neither infinite precision nor bitwise agreement with other reduction orders.

### 3.2 Comparison rule

For ordinary finite values:

```text
abs(actual - expected) <= atol + rtol × abs(expected)
atol = 1e-4
rtol = 1e-3
```

Check NaN and Inf separately from this tolerance.

### 3.3 Coverage

The unified suite should cover M=0 or N=0, K=0, null required pointers, square/rectangular matrices, manually verifiable small examples, positive/negative/fractional/zero values, deterministic random inputs, and future CPU/CUDA implementations.

## 4. In-process timing

`measure_operation` performs 5 warm-ups and 10 measured runs with `std::chrono::steady_clock`. Correctness checks occur outside timing. Reading C for a checksum afterward keeps the output observable.

Report minimum, P10, median, P90, maximum, GFLOP/s, and checksum. Transposed B has three boundaries:

- `transposed-kernel`: prepare BT before timing; measure only Matmul.
- `transpose-only`: preallocate BT; measure B-to-BT conversion.
- `transposed-e2e`: preallocate BT; measure transpose plus Matmul each iteration.

The last mode excludes allocation, random initialization, reference computation, verification, and output. It measures preallocated transpose plus compute rather than full-process latency.

## 5. Work and throughput

```text
operation_count = 2 × M × N × K
GFLOP/s = operation_count / (median_ms × 10^6)
```

Count multiplication and addition as one floating-point operation each. This is algorithmic throughput, not executed instruction count, regardless of whether FMA is one instruction.

For transpose-only:

```text
logical_bytes = 2 × N × K × sizeof(float)
logical_GB/s = logical_bytes / (median_ms × 10^6)
```

This counts one B read and one BT write, not actual hardware traffic. `transposed-e2e` reports effective_GFLOP/s using only Matmul FLOPs while including transpose time in the denominator.

## 6. Why retain the distribution?

Minimum approximates the best low-interference run but can be optimistic. Median is the primary statistic and resists a few outliers. P10/P90 describe the main range; maximum exposes tails from scheduling, background load, temperature, or frequency changes. Prefer relative comparisons within the same run/environment. Cross-run absolute latency changes do not automatically imply code performance changes.

## 7. GCC vectorization reports

Generate temporary reports with:

```bash
g++ -std=c++17 -O3 -Iinclude -fopt-info-vec-all -c src/cpu/ijk.cpp -o /tmp/matmul_ijk.o 2> /tmp/matmul_ijk.vec
g++ -std=c++17 -O3 -Iinclude -fopt-info-vec-all -c src/cpu/ikj.cpp -o /tmp/matmul_ikj.o 2> /tmp/matmul_ikj.vec
```

Recorded reports show a critical `ijk` access described as `not suitable for strided load`; `ikj` uses 16-byte and 8-byte vectors, with runtime loop versioning for possible pointer aliasing. The default transposed-B dot product uses 16-byte vectors. With `-march=native`, both ikj and the transposed-B kernel use 32-byte vectors. Successful vectorization alone does not imply a high-throughput reduction: inspect packed/scalar assembly too. Compiler reports explain compilation decisions but do not independently establish cache behavior.

## 8. perf counters

Counter mode repeats the selected operation a fixed number of times without reference computation, internal timing, or correctness verification:

```bash
perf stat -r 5 -e cycles,instructions,l1-dcache-loads,l1-dcache-load-misses ./build/cpu_benchmark ijk 256 --counter 100
```

`-r 5` runs the entire process independently five times and reports averages and variation. Observe cycles, retired instructions, L1D loads, L1D load misses, and miss rate (misses/loads). Combine counters with controlled experiments; a large miss count alone does not identify the responsible code or access pattern.

Allocate input, output, and workspace before the repeated loop. Prepare BT before the loop for transposed-kernel; transpose every iteration for transpose-only and transposed-e2e. Read a checksum once afterward. Dividing total events by iteration count approximates per-call counts.

## 9. Build variants

- Default Release: `-O3 -DNDEBUG`, for default portable semantics and primary results.
- Native comparison: `-O3 -DNDEBUG -march=native`, to study AVX2/FMA and vector width without changing the default build.
- Historical global fast-math mechanism experiment: `-O3 -DNDEBUG -march=native -ffast-math`, only for preliminary performance/assembly comparisons. It also changes the reference and cannot independently adjudicate numerical accuracy.
- Mixed-semantics numerics build: the default-off `MINI_GPU_BUILD_FAST_MATH_EXPERIMENT` creates a separate fast static library. Only transposed_b_fast.cpp uses native fast-math; the reference and numerics_test remain strict.

## 10. Measurement boundaries and limitations

External perf in ordinary timing mode includes allocation/initialization, one reference computation, 5 warm-ups, 10 measured calls, verification, checksum, and output. It supports comparisons of structurally similar ijk@255/256/257 cases with similar overhead, but is not a pure-kernel event count. It is unsuitable for precise ijk-versus-ikj attribution when runtimes differ greatly and overhead occupies a larger fraction of the faster case. Prefer counter mode for event attribution.

Counter mode still includes startup, initialization, and one checksum. Repeating the kernel 100 times reduces their relative contribution; it does not precisely gate an instruction interval.

## 11. Future measurement improvements

Planned additions: command-line control of M/N/K, implementation, warm-up and repeat counts; CSV output; commit/hardware/compiler/options metadata; CPU affinity and frequency/temperature records; CUDA event timing; separate H2D/kernel/D2H costs; Nsight Compute metrics; and mature BLAS/cuBLAS baselines. Each should serve a specific attribution question.

`numerics_test` is currently a reporting tool, not registered with CTest. Successful exit means comparison completed, not that the fast implementation met strict tolerance. Cancellation-case tolerance failures are recorded experimental results.
