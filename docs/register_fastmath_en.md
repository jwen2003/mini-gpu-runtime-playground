# Register blocking and fast-math experiment

[简体中文](register_fastmath_zh-CN.md)

At size 1024, strict 4×16 register blocking with 128³ outer tiles takes 88.315 ms. The full kernel is **1.466×** faster than original strict `ikj` (129.510 / 88.315) and **1.541×** faster than strict cache blocking (136.114 / 88.315).

## Method

The three kernels are original `ikj`, cache-blocked `ikj`, and register-blocked `ikj`. Each fast counterpart is built from the same source as its strict counterpart. Only the separate `matmul_register_fast` static library receives `-ffast-math`. The reference and harness use the default strict build. The executable does not link with fast-math flags. The experiment uses the phase-one x86-64 GCC 15.2.0 Release configuration (`-O3 -DNDEBUG`), with 128-bit SSE and no native ISA flags. SSE is part of the x86-64 baseline. The CMake option is disabled by default and checks the target architecture and compiler.

Register blocking retains one accumulator per output lane through a K panel. The driver traverses `ii → jj → kk`. Full tiles load C before the microkernel's K loop and store it after the loop. Partial M/N tiles use an increasing-K fallback, and K panels clip to the remaining depth. The main outer tile is 128³ and the sensitivity tile is 64³. At each outer size the candidate microtiles are 2×8, 4×8, and 4×16. The 8×16 configuration is a register-pressure control.

On the Ryzen 7 7730U under WSL2 Ubuntu, two fresh processes per square size collect nine interleaved rounds each after three warm-ups per configuration. Each process uses the same deterministic data and a different deterministic order seed. Each timed sample batches seven calls at size 128 and one call at the other sizes. Allocation, input generation, and correctness verification occur outside the timed interval. The optional size 2048 was omitted to limit the cost of measuring all 22 configurations twice. These blocking experiments cover this CPU and build only. Other CPUs and AVX2, native, or FMA builds were outside the measured grid.

```bash
cmake -S . -B build-register -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DMINI_GPU_BUILD_REGISTER_EXPERIMENT=ON
cmake --build build-register -j4
ctest --test-dir build-register --output-on-failure
python3 benchmarks/run_register_experiment.py build-register /tmp/register-reproduction --cpu 4
```

[Raw data, compile commands, machine information, and six disassemblies](../experiments/blocked_ikj/ryzen7730u/register_fastmath/)

Published build records and logs use `<REPO>` for the recording checkout path.

Recompute the saved tables without collecting new measurements.

```bash
python3 benchmarks/verify_blocking_results.py
```

## Numerical results

The strict harness ran 12 ordinary shapes and all five existing cancellation cases, both in their original shape and replicated across an 8×16 output to exercise the full microkernels. All 484 comparisons across the 22 configurations matched strict FP32 ikj bit for bit. The combined oracle tolerance remains `1e-4 + 1e-3 × abs(reference)`. Ordinary inputs all pass. Cancellation cases are reported against the double reference, while strict pass/fail requires the original FP32 accumulation behavior. Counts below include repeated comparisons across configurations. Relative error near zero can be large even when absolute error is small.

| Version | Bitwise mismatches vs ikj | Ordinary max absolute | Ordinary max relative | Ordinary max ULP | Cancellation max absolute | Cancellation max relative | Cancellation max ULP | Cancellation oracle tolerance failures |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|
| `strict_ikj` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 516 |
| `fast_ikj` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 516 |
| `strict_cache_blocked` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 1032 |
| `fast_cache_blocked` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 1032 |
| `strict_register_blocked` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 4128 |
| `fast_register_blocked` | 0 | 1.71661e-05 | 0.505297 | 8,484,567 | 2047 | 0.999512 | 92,274,688 | 4128 |

## Assembly and spills

The ikj and cache-blocked vector loops both read and write C for each k. The microkernel uses `movss` plus `shufps` to broadcast A and `mulps` plus `addps` to update distinct output columns. GCC unrolls the fixed row and vector lanes, with one K step per hot loop iteration. The four full-tile microkernel disassemblies match across strict and fast. The compiler emitted neither FMA nor horizontal reduction in these loops.

Stack reservations are from `sub ..., %rsp` and exclude callee-saved pushes and red-zone use. The ikj reservations are 104 bytes strict and 88 bytes fast. Cache-blocked reserves 264 bytes in both. The following counts are static vector stack operands inside each microkernel's K back edge, including memory operands to arithmetic instructions.

| Microtile | K loop address range | Stack reservation bytes | Vector stack accesses per K step | C handling |
|:---|:---|---:|---:|:---|
| 2×8 | 0x40–0x7e | 0 | 0 | panel load/store |
| 4×8 | 0x110–0x18a | 0 | 0 | panel load/store |
| 4×16 | 0x2c0–0x3c7 | 32 | 12 | panel load/store, stack spill |
| 8×16 | 0x720–0x999 | 432 | 44 | panel load/store, stack spill |

For example, 4×16 updates a spilled vector with `addps -0x78(%rsp),%xmm15` at 0x2e2, then writes it to the same slot with `movaps %xmm15,-0x78(%rsp)` at 0x2e8. The 8×16 loop has the same pattern at 0x74f/0x755 with slot `-0x68(%rsp)`. Spill traffic can hit L1D. The loop-level stack evidence establishes spilling independently of cache misses.

## Six-version timing comparison

Outer tile 128³. Both register columns use the same 4×16 microtile, the fastest of the three planned candidates in this grid for both policies. Each cell is **median ms [P10–P90] / GFLOP/s / speedup vs strict ikj**. The 64³ sensitivity measurements and all microtile/control measurements are in the [176-row summary](../experiments/blocked_ikj/ryzen7730u/register_fastmath/timing_summary.csv). The [3,168 raw samples](../experiments/blocked_ikj/ryzen7730u/register_fastmath/timing_samples.csv) retain pass and round.

| Size | `strict_ikj` | `fast_ikj` | `strict_cache_blocked` | `fast_cache_blocked` | `strict_register_blocked` | `fast_register_blocked` |
|---:|---:|---:|---:|---:|---:|---:|
| 128 | 0.175 [0.161–0.209] / 23.98 / 1.000 | 0.171 [0.163–0.253] / 24.55 / 1.024 | 0.176 [0.168–0.261] / 23.79 / 0.992 | 0.183 [0.168–0.242] / 22.94 / 0.957 | 0.102 [0.098–0.136] / 41.24 / 1.720 | 0.104 [0.097–0.133] / 40.20 / 1.676 |
| 255 | 1.452 [1.387–2.278] / 22.84 / 1.000 | 1.426 [1.358–1.739] / 23.25 / 1.018 | 1.586 [1.483–2.184] / 20.92 / 0.916 | 1.641 [1.550–2.222] / 20.20 / 0.885 | 1.093 [1.003–1.388] / 30.33 / 1.328 | 1.063 [1.007–1.341] / 31.19 / 1.366 |
| 256 | 1.231 [1.190–1.535] / 27.26 / 1.000 | 1.236 [1.201–1.516] / 27.14 / 0.996 | 1.410 [1.311–1.615] / 23.80 / 0.873 | 1.437 [1.341–1.617] / 23.36 / 0.857 | 0.836 [0.800–0.927] / 40.13 / 1.472 | 0.853 [0.803–1.085] / 39.36 / 1.444 |
| 257 | 1.659 [1.506–2.124] / 20.46 / 1.000 | 1.640 [1.463–2.324] / 20.70 / 1.011 | 1.923 [1.724–2.719] / 17.65 / 0.863 | 2.031 [1.835–2.264] / 16.72 / 0.817 | 1.160 [1.061–1.312] / 29.27 / 1.431 | 1.151 [1.062–1.463] / 29.50 / 1.442 |
| 511 | 15.127 [14.516–16.410] / 17.64 / 1.000 | 14.910 [14.058–17.615] / 17.90 / 1.015 | 15.592 [14.088–16.432] / 17.12 / 0.970 | 16.141 [14.890–17.117] / 16.53 / 0.937 | 9.117 [8.420–10.184] / 29.27 / 1.659 | 8.825 [8.441–9.615] / 30.24 / 1.714 |
| 512 | 14.555 [12.918–15.627] / 18.44 / 1.000 | 14.057 [13.264–15.368] / 19.10 / 1.035 | 13.949 [12.925–15.133] / 19.24 / 1.043 | 14.391 [13.934–16.236] / 18.65 / 1.011 | 8.723 [7.861–9.547] / 30.77 / 1.669 | 8.554 [7.697–9.327] / 31.38 / 1.702 |
| 513 | 16.383 [14.682–17.968] / 16.48 / 1.000 | 15.881 [14.972–17.616] / 17.00 / 1.032 | 17.457 [15.871–18.899] / 15.47 / 0.939 | 18.450 [17.002–19.744] / 14.63 / 0.888 | 10.333 [9.312–11.845] / 26.13 / 1.586 | 10.238 [9.228–11.149] / 26.37 / 1.600 |
| 1024 | 129.510 [116.992–187.998] / 16.58 / 1.000 | 126.851 [116.195–165.549] / 16.93 / 1.021 | 136.114 [121.056–180.675] / 15.78 / 0.951 | 155.471 [131.887–207.522] / 13.81 / 0.833 | 88.315 [76.965–105.172] / 24.32 / 1.466 | 87.196 [75.088–105.120] / 24.63 / 1.485 |

## Relative gains

Every gain is baseline median latency divided by target median latency. Cache blocking uses original ikj under the same policy. Register blocking uses cache blocking under the same policy. Fast-math compares policies within the same kernel and tile. The preceding timing table separately reports full kernel speedup against original strict ikj, including output zeroing. The interaction factor is (fast register / strict register speedup) divided by (fast cache / strict cache speedup), equivalently the ratio of the register gains under the two policies. A value near 1 is consistent with multiplicative independence. Above or below 1 indicates apparent positive or negative interaction in the timings. The complete [ratio grid](../experiments/blocked_ikj/ryzen7730u/register_fastmath/relative_gains.csv) includes both outer tiles and all microtiles.

| Size | Cache strict | Cache fast | Register strict | Register fast | Fast ikj | Fast cache | Fast register | Interaction |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 128 | 0.992 | 0.935 | 1.733 | 1.752 | 1.024 | 0.965 | 0.975 | 1.011 |
| 255 | 0.916 | 0.869 | 1.450 | 1.544 | 1.018 | 0.966 | 1.028 | 1.065 |
| 256 | 0.873 | 0.861 | 1.686 | 1.685 | 0.996 | 0.981 | 0.981 | 0.999 |
| 257 | 0.863 | 0.808 | 1.658 | 1.765 | 1.011 | 0.947 | 1.008 | 1.064 |
| 511 | 0.970 | 0.924 | 1.710 | 1.829 | 1.015 | 0.966 | 1.033 | 1.070 |
| 512 | 1.043 | 0.977 | 1.599 | 1.682 | 1.035 | 0.969 | 1.020 | 1.052 |
| 513 | 0.939 | 0.861 | 1.689 | 1.802 | 1.032 | 0.946 | 1.009 | 1.067 |
| 1024 | 0.951 | 0.816 | 1.541 | 1.783 | 1.021 | 0.875 | 1.013 | 1.157 |

## Hardware counters

Outer tile 128³, pinned to logical CPU 4. Medians of three independent processes, normalized per kernel call. All counters are in millions per call except IPC, which is the median of per-process instructions divided by cycles. The core and supplemental event groups ran separately. All nine events returned counts with 100% running time. The load/store columns report AMD dispatch events, which are neither retired operations nor bytes. Counts include setup and checksum. The generic cache events retain their perf names without assigning a cache level.

| Size | Version | Microtile | Cycles | Instructions | IPC | L1D loads | L1D load misses | Cache references | Cache misses | Load dispatch | Store dispatch | Frontend stalled cycles |
|---:|:---|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 128 | `fast_cache_blocked` | none | 0.772 | 4.548 | 5.893 | 1.634 | 0.133 | 0.188 | 0.002 | 1.118 | 0.528 | 0.005 |
| 128 | `fast_register_blocked` | 4x16 | 0.451 | 2.102 | 4.657 | 0.482 | 0.096 | 0.220 | 0.084 | 0.475 | 0.210 | 0.004 |
| 128 | `fast_register_blocked` | 8x16 | 0.439 | 2.186 | 4.976 | 0.591 | 0.045 | 0.091 | 0.019 | 0.572 | 0.375 | 0.002 |
| 128 | `strict_cache_blocked` | none | 0.759 | 4.581 | 6.033 | 1.625 | 0.133 | 0.185 | 0.002 | 1.101 | 0.528 | 0.004 |
| 128 | `strict_register_blocked` | 4x16 | 0.449 | 2.102 | 4.684 | 0.482 | 0.101 | 0.217 | 0.076 | 0.475 | 0.210 | 0.002 |
| 128 | `strict_register_blocked` | 8x16 | 0.446 | 2.186 | 4.902 | 0.590 | 0.047 | 0.102 | 0.025 | 0.572 | 0.375 | 0.002 |
| 512 | `fast_cache_blocked` | none | 55.334 | 292.141 | 5.280 | 102.697 | 11.799 | 22.958 | 3.126 | 71.603 | 33.762 | 0.288 |
| 512 | `fast_register_blocked` | 4x16 | 32.783 | 135.583 | 4.136 | 30.879 | 4.866 | 11.848 | 4.321 | 30.446 | 13.398 | 0.247 |
| 512 | `fast_register_blocked` | 8x16 | 31.144 | 140.945 | 4.526 | 37.879 | 2.972 | 6.169 | 1.236 | 36.692 | 23.986 | 0.239 |
| 512 | `strict_cache_blocked` | none | 53.625 | 294.214 | 5.487 | 103.304 | 11.134 | 21.239 | 2.052 | 70.550 | 33.758 | 0.633 |
| 512 | `strict_register_blocked` | 4x16 | 31.927 | 135.579 | 4.247 | 30.894 | 5.100 | 13.834 | 5.283 | 30.448 | 13.399 | 0.256 |
| 512 | `strict_register_blocked` | 8x16 | 30.743 | 140.937 | 4.584 | 37.866 | 3.255 | 7.082 | 1.736 | 36.683 | 23.990 | 0.221 |
| 1024 | `fast_cache_blocked` | none | 499.086 | 2347.934 | 4.704 | 811.233 | 104.609 | 192.852 | 26.703 | 573.265 | 270.516 | 2.469 |
| 1024 | `fast_register_blocked` | 4x16 | 282.345 | 1095.473 | 3.880 | 248.088 | 43.308 | 110.873 | 39.257 | 244.051 | 107.624 | 1.925 |
| 1024 | `fast_register_blocked` | 8x16 | 278.347 | 1138.366 | 4.090 | 304.646 | 30.376 | 56.745 | 9.981 | 293.989 | 192.352 | 1.590 |
| 1024 | `strict_cache_blocked` | none | 433.675 | 2364.515 | 5.452 | 820.578 | 90.559 | 169.361 | 10.401 | 564.860 | 270.504 | 3.711 |
| 1024 | `strict_register_blocked` | 4x16 | 280.037 | 1095.439 | 3.912 | 248.058 | 41.947 | 104.704 | 36.340 | 244.058 | 107.625 | 2.066 |
| 1024 | `strict_register_blocked` | 8x16 | 272.063 | 1138.303 | 4.184 | 302.957 | 30.489 | 61.462 | 13.194 | 293.925 | 192.376 | 1.558 |

At 1024, the strict 8×16 control has both a lower kernel median (85.244 vs 88.315 ms) and fewer PMU cycles (272.063M vs 280.037M) than strict 4×16. Under fast-math the 8×16 kernel median is higher (88.283 vs 87.196 ms), while its PMU cycles are lower (278.347M vs 282.345M). Timing ranks the 18 kernel-only samples per configuration, with output zeroing inside the kernel and setup and verification outside timing. The three PMU trials use separate processes and include initialization and checksum. These measurements use different units and boundaries. The PMU cycle ranking therefore does not replace the timing ranking.

## Conclusions and dispatch

- **Measured.** Simple cache blocking showed no stable gain in the measured range. With the 128³ outer tile, 4×16 is the fastest of the three planned microtiles under both policies at each size. The 8×16 pressure control is outside that candidate ranking. Strict 4×16 beat both strict baselines in each of the two independent passes at every size. At 1024 its gains are 1.466× over original strict ikj and 1.541× over strict cache blocking. With a 64³ outer tile, the strict 4×16 timing ratio relative to 128³ ranges from 0.951× to 1.011× when expressed as speedup. The fast ratio ranges from 0.953× to 1.009×. The 8×16 pressure control can be faster despite spills. Greater reuse or parallelism could offset spill costs. Their individual contributions remain unmeasured.
- **Assembly and PMU.** At 1024, strict 4×16 cuts instructions from 2,364.515M to 1,095.439M and store dispatches from 270.504M to 107.625M per call versus strict cache blocking. The two smaller microtiles remove repeated C loads/stores within the full K loop without vector spills. The larger tiles remove repeated C-buffer accesses but repeatedly access stack slots. The 8×16 control dispatches more stores than 4×16 yet reports fewer L1D load misses. This is consistent with some spill traffic hitting cache.
- **Fast-math and interaction.** On the primary 4×16 comparison, fast register speedup is 0.975×–1.033×, and all four strict/fast microkernel bodies match. Interaction factors are near 1 at 128 and 256. The largest apparent positive interaction is 1.157× at 1024. The separate passes give 1.093× and 1.108× there, primarily because the fast cache-blocked comparator slows down. PMU also shows higher cycles for fast cache blocking at 1024 (499.086M versus 433.675M). This is a contrast in the measured versions. It does not establish that reassociation improves the microkernel or that the interaction generalizes.
- **Open questions.** Code generation outside the full-tile loop differs across policies. The data do not isolate the contributions of register allocation outside that loop, access scheduling, cache behavior, clock variation, or WSL to the strict/fast differences. Performance on rectangular shapes and larger sizes still needs measurement.
- **Dispatch.** Under strict policy, qualify strict 4×16 with 128³ as the leading experimental candidate for the measured square workload and retain strict ikj as the fallback for uncharacterized shapes and platforms. AllowReassociation permits fast kernels but does not require them. The measurements support keeping the strict register kernel eligible there as well. Any fast path should require explicit policy and a reproducible gain on the target workload. Matching sampled outputs do not turn fast-math into a strict guarantee.

Next, measure rectangle and tail-heavy crossover points. Compare the same SSE 4×16 shape against a version with lower live-vector pressure, using hot-loop stack operands and store dispatches to verify the change. Treat any native ISA or FMA-enabled study as a separate experiment, with contraction policy and bitwise results reported explicitly.

The follow-up compares three equal-accumulator microtiles against 4×16 using strict SSE and the same outer tile. The follow-up has its own paired timing data. [Strict SSE microtile search](../experiments/blocked_ikj/ryzen7730u/microtile_search/report_en.md)
