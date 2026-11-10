# From Matrix Multiplication to GPU Kernels: CPU Memory Access Analysis

[简体中文](cpu_memory_access_analysis_zh-CN.md) | [English](cpu_memory_access_analysis_en.md)

## 1. Objective

Explain performance differences between mathematically equivalent CPU Matmul implementations and investigate the special cpu_ijk trough at N=256. The evidence chain is loop-order observation, cache/SIMD hypotheses, neighboring-size scans, fixed M/K to isolate N, cache geometry, GCC vectorization reports, and perf L1D events.

## 2. Loop orders

### 2.1 i-j-k

```cpp
for (i)
    for (j)
        for (k)
            C[i * N + j] += A[i * K + k] * B[k * N + j];
```

As k changes, A is contiguous, B advances by N floats, and one C element is normally reduced in registers before writeback.

### 2.2 i-k-j

```cpp
for (i)
    for (k)
        for (j)
            C[i * N + j] += A[i * K + k] * B[k * N + j];
```

As j changes, A[i * K + k] is reused and B/C are contiguous. C is repeatedly updated across k iterations.

## 3. Initial observations

Early M=N=K=256 experiments gave median ikj latency around 1.2–1.6 ms versus 19–22 ms for ijk, with matching checksums and successful correctness verification. Timing alone cannot separate cache behavior, SIMD, code generation, and special-size effects.

## 4. Dimension experiment

### 4.1 Initial scan

Comparing square dimensions 255/256/257 showed ijk@256 taking nearly twice as long as its neighbors; ikj had no corresponding trough.

### 4.2 Isolating N

Fix M=K=256 and vary only N:

| N | cpu_ijk GFLOP/s |
|---:|---:|
| 248 | 3.20 |
| 252 | 3.19 |
| 255 | 3.13 |
| 256 | **1.69** |
| 257 | 3.13 |
| 260 | 3.18 |
| 264 | 3.21 |

Except at 256, throughput stays around 3.1–3.2 GFLOP/s. With M/K unchanged, the anomaly tracks the N-dependent access structure rather than simply increased work.

## 5. Cache geometry and mapping

Ryzen 7 7730U L1D has 32 KiB per core, 64-byte lines, 64 sets, and 8-way associativity.

```text
stride_bytes = N × sizeof(float)
N=256: stride_bytes = 256 × 4 = 1024 bytes
stride_lines = 1024 / 64 = 16 cache lines
idealized set sequence: 0 → 16 → 32 → 48 → 0 → ...
```

Regular column access concentrates lines in a few sets. A 256-term dot product places far more than eight competing lines in each affected set, creating conditions for severe cache-set conflict. N=255/257 breaks the power-of-two stride and spreads access over more sets.

This is a mechanism inference from row-major indexing and cache geometry. Corresponding hardware miss increases provide stronger attribution.

## 6. Vectorization evidence

GCC 15.2 with -O3 reports:

```text
ijk: not vectorized: not suitable for strided load
ikj: loop vectorized using 16 byte vectors
ikj: loop vectorized using 8 byte vectors
ikj: loop versioned for vectorization because of possible aliasing
```

Strided B loads obstruct ideal contiguous vector access. The ijk report also contains a successful 16-byte vectorization entry, so it would be incorrect to claim ijk has no SIMD anywhere. For ikj, the interface does not express non-overlap to the compiler, causing runtime alias checks and alternate loop paths. Reports support vectorization opportunities, but cannot independently prove the N=256 cache conflict.

## 7. Controlled perf experiment

Run ijk separately for N=255, 256, and 257:

```bash
./build/cpu_benchmark ijk 255
./build/cpu_benchmark ijk 256
./build/cpu_benchmark ijk 257
perf stat -r 5 -e cycles,instructions,l1-dcache-loads,l1-dcache-load-misses ./build/cpu_benchmark ijk N
```

| Metric | N=255 | N=256 | N=257 |
|---|---:|---:|---:|
| Cycles | 763,293,396 | **1,396,785,486** | 770,428,024 |
| Instructions | 1,522,166,792 | 1,528,120,554 | 1,534,064,540 |
| L1D loads | 340,769,280 | 339,806,194 | 343,598,688 |
| L1D load misses | 23,054,299 | **278,445,240** | 25,748,970 |
| L1D miss rate | 6.77% | **81.94%** | 7.49% |
| Process elapsed time | 0.1875 s | **0.3424 s** | 0.1888 s |

Relative to 255, instructions increase only 0.39%, loads decrease 0.28%, misses grow about 12.1 times, and cycles about 1.83 times. Comparison with 257 gives the same conclusion: similar work indicators, but sharply higher misses and cycles at 256.

## 8. Conclusions

Confirmed observations are the reproducible ijk@256 trough, its absence at 255/257, similar instructions/load counts, miss rate rising from about 7% to 82%, and corresponding cycle increases and throughput loss. Compiler evidence identifies strided B loads in ijk and vectorized contiguous loops in ikj.

The supported causal explanation is:

```text
N=256 → 1024-byte B stride → 16-line mapping step
→ concentration in a few L1D sets → exceeds 8-way capacity
→ conflict misses → increased cycles and reduced throughput
```

Address formulas, geometry, neighboring-size controls, and hardware events jointly support this attribution beyond timing alone.

## 9. Applicability and limitations

Results apply to AMD Ryzen 7 7730U, the recorded WSL2 environment, GCC 15.2, -O3 -DNDEBUG, FP32 row-major data, the current ijk implementation, and fixed M=K=256. They do not establish that all power-of-two sizes are slower, all CPUs show the same magnitude, all cache levels map identically, or ikj has a universal speedup.

External perf includes initialization, one reference calculation, warm-ups, verification, and output. It is not a pure-kernel count. For ijk@255/256/257, matching surrounding work and similar kernel structure, with event differences much larger than noise, support the controlled attribution.

## 10. Transposed-B intervention

Convert B[K][N] to B_transposed[N][K]. Dot products then read B_transposed[j][k] contiguously. Measurement questions include kernel-only cost, transpose-plus-compute cost, amortization through reuse, disappearance of the 255/256/257 anomaly, vectorization, miss rate, and whether reduced C updates offset transposition versus ikj.

| N | Transposed kernel median | GFLOP/s |
|---:|---:|---:|
| 255 | 9.3937 ms | 3.5581 |
| 256 | 9.4978 ms | 3.5329 |
| 257 | 9.4513 ms | 3.5641 |

The special N=256 trough disappears.

| Case | Cycles/call | Instructions/call | L1D misses/call | Miss rate |
|---|---:|---:|---:|---:|
| ijk@255 | 47.64M | 92.73M | 1.38M | 6.51% |
| ijk@256 | 87.25M | 93.09M | 17.36M | 82.10% |
| BT@255 | 41.11M | 63.55M | 1.05M | 12.48% |
| BT@256 | 41.30M | 63.80M | 1.06M | 12.52% |
| ikj@256 | 5.75M | 34.85M | 1.06M | 8.34% |

BT@255/256 have essentially matching events. Removing the N-dependent stride removes both cache-conflict and cycle anomalies, providing an intervention supporting the mechanism.

## 11. Why contiguous dot products remain slower than ikj

Under strict floating-point semantics, BT and ikj have nearly identical absolute L1D misses, but BT requires about 7–9 times as many cycles. Remaining L1D misses cannot primarily explain the gap.

Native BT assembly includes:

```asm
vmovups ymm0, ...
vmulps  ymm0, ymm0, ...
vaddss  xmm1, xmm1, ...
...
```

GCC computes eight products with 256-bit vectors, then uses shuffle/extract operations and serial vaddss to preserve reduction order. Wider SIMD reduces instructions about 33% but cycles only 4%; IPC falls from 1.54 to 1.08.

The ikj main loop includes:

```asm
vbroadcastss ymm1, xmm2
vmovups     ymm0, ...
vfmadd213ps ymm0, ymm1, ...
vmovups     ..., ymm0
```

Lanes represent different C elements, avoiding cross-lane reduction. Native ikj cycles decrease about 24%.

## 12. Fast-math mechanism experiment

Reassociation permits packed accumulation:

```asm
vmulps ymm0, ymm0, ...
vaddps ymm1, ymm1, ymm0
```

Only one horizontal reduction is needed after the loop.

| Metric, 100 calls | BT native strict | BT fast-math |
|---|---:|---:|
| Cycles | 3,947.9M | 434.1M |
| Instructions | 4,274.3M | 1,390.6M |
| L1D loads | 637.4M | 637.5M |
| L1D misses | 106.1M | 106.4M |
| IPC | 1.08 | 3.20 |

Cache events barely change while cycles fall about 89%, attributing the gain to reduction instructions rather than further cache improvement. Fast BT and fast ikj have comparable cycles, instructions, misses, and IPC. See the [methodology](benchmark_methodology_en.md) for build variants and measurement boundaries.

## 13. Current conclusion and next stage

Original ijk has strided B access and an N=256 cache conflict. Transposition creates contiguous dot products and removes the conflict, but strict order retains a serial scalar reduction. Reassociation enables packed accumulation and sharply reduces cycles while introducing numerical risk.

See [numerical semantics](numerical_semantics_analysis_en.md) for counterexamples. The [CPU cache blocking report](blocked_ikj_en.md) records the follow-up block-size sweep. The naive transpose was measured at roughly 0.126 ms.
