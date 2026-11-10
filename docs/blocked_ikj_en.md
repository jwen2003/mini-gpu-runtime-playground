# CPU cache blocking experiment

[简体中文](blocked_ikj_zh-CN.md)

## Kernel and validation

`matmul_cpu_blocked_ikj` visits output tiles in `ii → jj` order and reduction panels in increasing `kk` order. Within each panel, `i → k → j` preserves the baseline's increasing K order for each output element and gives the innermost loop contiguous B and C accesses. The kernel zeros C once, accepts independent positive BM, BN, and BK, and clips tails to the remaining extents. The build uses strict FP32 operations. Both kernels use the same compiler flags and row-major input buffers.

The numerical test compares each blocked result with the existing FP32 `ikj` baseline bit for bit, and independently records bitwise matches, absolute and relative error, and ULP distance against the double-accumulating reference. Ordinary finite inputs use `1e-4 + 1e-3 × abs(reference)`. Relative error uses the same minimum-positive-normal denominator floor as the existing numerics test. The test covers square sizes 1, 31, 32, 33, 255, 256, 257 and rectangles 31×32×33, 127×257×63, 33×17×65. It checks five cubic block sizes plus 7×16×3 and 3×5×2, empty output, K=0, and zero block size.

The cancellation probe uses `[1e10, -1e10, 1, 1, 1e10, -1e10, 1, 1]` and a column of ones. Both strict FP32 kernels return 2, and the double oracle returns 4. The probe explicitly checks those answers and reports the expected oracle tolerance failure. The other cases must satisfy the existing tolerance and match the FP32 baseline bit for bit.

## Reproduction

AMD Ryzen 7 7730U, WSL2 Ubuntu, GCC 15.2.0, C++17 Release with `-O3 -DNDEBUG` and `-Wall -Wextra -Wpedantic`. Linux exposes 8 cores and 16 logical CPUs. Timing and PMU processes were pinned to logical CPU 4. L1D is 32 KiB per core, 8-way, 64 sets with 64-byte lines. L2 is 512 KiB per core, 8-way. Shared L3 is 16 MiB, 16-way.

```bash
cmake -S . -B build-blocked -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build-blocked -j4
ctest --test-dir build-blocked --output-on-failure
python3 benchmarks/run_blocked_experiment.py build-blocked /tmp/blocked-reproduction --cpu 4
./build-blocked/cpu_benchmark blocked-sweep 127 257 63 7 16 3
objdump -d -C build-blocked/CMakeFiles/matmul_cpu.dir/src/cpu/blocked_ikj.cpp.o
```

The sweep uses deterministic FP32 inputs. Each of two fresh processes per size warms each variant five times and checks the reference outside timing. Each process collects 21 rounds in deterministically shuffled order, batching seven calls at size 128 and one elsewhere. Timing includes zeroing C and uses the same preallocated buffers for all variants. Throughput is `2 × M × N × K / time`; speedup divides baseline median by blocked median.

[Environment and exact compile commands](../experiments/blocked_ikj/ryzen7730u/environment.json) · [Raw timing samples](../experiments/blocked_ikj/ryzen7730u/timing_samples.csv) · [Timing summary](../experiments/blocked_ikj/ryzen7730u/timing_summary.csv) · [Numerical report](../experiments/blocked_ikj/ryzen7730u/numerics.csv) · [PMU samples](../experiments/blocked_ikj/ryzen7730u/pmu_samples.csv) · [PMU commands and output](../experiments/blocked_ikj/ryzen7730u/perf_log.txt)

Published environment and command logs replace the recording checkout path with `<REPO>`. The four CSV files are byte-for-byte originals. [Original SHA-256 hashes](../experiments/blocked_ikj/ryzen7730u/original_sha256.txt) also cover both text artifacts before path substitution and removal of the trailing blank line in the PMU log.

Recompute the saved tables without collecting new measurements.

```bash
python3 benchmarks/verify_blocking_results.py
```

## Numerical results

All 77 shape/block comparisons matched strict FP32 ikj bit for bit (1,637,146 element comparisons, including repeated checks across block shapes). On the 70 ordinary-input comparisons, 192,612 of 1,637,139 comparisons matched the double oracle bit for bit. The maxima against that oracle were 1.62125e-5 absolute error, 0.034902 relative error, and 351,798 ULPs. All ordinary outputs passed the combined tolerance, with zero classification and signed-zero mismatches. The cancellation probe yielded absolute error 2, relative error 0.5, and 8,388,608 ULPs against the double oracle for all seven block shapes.

## Timing results

Each cell is **median ms / GFLOP/s / speedup vs original strict ikj** from 42 samples. A block label gives BM=BN=BK. The 1024 sweep took about 45 seconds per pass. The optional 2048 sweep was omitted because of the cost of the full grid and reference calculation.

| Square size | ikj | 8 | 16 | 32 | 64 | 128 |
|---:|---:|---:|---:|---:|---:|---:|
| 128 | 0.203 / 20.68 / 1.000 | 0.675 / 6.21 / 0.300 | 0.401 / 10.47 / 0.506 | 0.264 / 15.90 / 0.769 | 0.220 / 19.02 / 0.920 | 0.202 / 20.81 / 1.006 |
| 255 | 1.580 / 20.99 / 1.000 | 5.202 / 6.38 / 0.304 | 3.276 / 10.12 / 0.482 | 2.228 / 14.88 / 0.709 | 1.907 / 17.39 / 0.828 | 1.694 / 19.58 / 0.933 |
| 256 | 1.404 / 23.89 / 1.000 | 5.324 / 6.30 / 0.264 | 3.201 / 10.48 / 0.439 | 2.015 / 16.65 / 0.697 | 1.698 / 19.76 / 0.827 | 1.542 / 21.75 / 0.910 |
| 257 | 1.691 / 20.08 / 1.000 | 5.533 / 6.14 / 0.306 | 3.623 / 9.37 / 0.467 | 2.563 / 13.24 / 0.660 | 2.154 / 15.76 / 0.785 | 1.917 / 17.71 / 0.882 |
| 511 | 15.834 / 16.85 / 1.000 | 45.474 / 5.87 / 0.348 | 28.919 / 9.23 / 0.548 | 21.066 / 12.67 / 0.752 | 17.876 / 14.93 / 0.886 | 16.266 / 16.41 / 0.973 |
| 512 | 14.777 / 18.17 / 1.000 | 49.538 / 5.42 / 0.298 | 30.319 / 8.85 / 0.487 | 18.933 / 14.18 / 0.781 | 16.541 / 16.23 / 0.893 | 15.195 / 17.67 / 0.972 |
| 513 | 15.665 / 17.24 / 1.000 | 48.058 / 5.62 / 0.326 | 30.671 / 8.80 / 0.511 | 22.440 / 12.03 / 0.698 | 18.787 / 14.37 / 0.834 | 17.017 / 15.87 / 0.921 |
| 1024 | 120.302 / 17.85 / 1.000 | 618.314 / 3.47 / 0.195 | 328.788 / 6.53 / 0.366 | 191.648 / 11.21 / 0.628 | 153.579 / 13.98 / 0.783 | 129.152 / 16.63 / 0.931 |

## Hardware counters

Use `perf stat` with the six recorded user-mode events. Each row aggregates three independent processes by the median of event count divided by the fixed call count. IPC is the median of per-process instructions/cycles. All event counts are in millions per call, except IPC. The counts still include startup, allocation, input generation, and one checksum. The process executes repeated kernels without the reference. WSL exposed all requested generic events at 100% running time. No model-specific event was used or substituted. Generic cache events are reported under their perf names, without assigning them to a specific cache level.

Size 511 was the closest observed midrange point to parity with ikj. The 256 block is an extra large-block probe at 511 and 1024, outside the main timing grid. At 128 the best candidate spans the entire matrix, so there is no distinct larger effective tile.

| Size | Block | Cycles | Instructions | IPC | L1D loads | L1D load misses | Cache references | Cache misses |
|---:|:---|---:|---:|---:|---:|---:|---:|---:|
| 128 | ikj | 0.754 | 4.504 | 5.98 | 1.609 | 0.132 | 0.197 | 0.002 |
| 128 | 8 | 2.457 | 11.283 | 4.59 | 2.512 | 0.077 | 0.161 | 0.049 |
| 128 | 128 | 0.789 | 4.587 | 5.81 | 1.626 | 0.133 | 0.189 | 0.002 |
| 511 | ikj | 55.879 | 282.470 | 5.06 | 123.035 | 8.486 | 17.192 | 0.212 |
| 511 | 8 | 165.676 | 728.254 | 4.40 | 175.348 | 6.545 | 15.581 | 5.910 |
| 511 | 128 | 57.353 | 301.745 | 5.26 | 124.466 | 10.618 | 21.514 | 2.450 |
| 511 | 256 | 63.536 | 289.566 | 4.56 | 123.563 | 10.178 | 23.556 | 4.395 |
| 1024 | ikj | 391.605 | 2191.198 | 5.60 | 815.139 | 68.590 | 138.322 | 1.600 |
| 1024 | 8 | 2158.966 | 5790.583 | 2.68 | 1276.602 | 198.756 | 323.571 | 102.404 |
| 1024 | 128 | 428.488 | 2367.033 | 5.52 | 821.181 | 91.413 | 172.799 | 12.875 |
| 1024 | 256 | 502.267 | 2269.218 | 4.52 | 822.366 | 84.546 | 219.806 | 36.180 |

## Findings and open questions

**Measured.** No tested size showed a stable win, defined here as median speedup above 1.05× and at least 90% faster paired rounds. Block 128 had the lowest blocked median at every tested size. At size 128 it covers the entire matrix, with 1.006× median speedup and only 16 of 42 faster rounds. At 511 the best blocked median was 0.973×, and at 1024 it was 0.931×. The 256 probe used more cycles than 128 at both measured points. The best observed cubic candidate did not change across the grid. Independent BM, BN, and BK were tested for correctness only.

**Counter and assembly evidence.** At 128 and 511, the 8 block reduced reported L1D load misses versus ikj while retiring roughly 2.5× as many instructions and taking roughly 3× as many cycles. GCC emits packed `mulps` and `addps` across adjacent output columns plus scalar paths. Blocking adds loop and boundary work and shortens the contiguous inner runs. The counters support an instruction-cost penalty. At 1024 the 128 block has higher instructions and reported misses than ikj. These observations do not isolate each source of the gap or identify per-tile cache residency.

**Open.** Larger matrices, non-cubic blocks, and a native strict build could change the outcome. Cache capacity alone cannot determine residency. Row strides, associativity, cache-line utilization, competing data, and hardware prefetch can all matter. The measurements do not partition those effects or establish a universal crossover.

## Follow-up

The [register blocking report](register_fastmath_en.md) compares the cache-blocked kernel with register-blocked variants under matched compiler settings.
