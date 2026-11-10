# Strict SSE microtile shape search

[简体中文](report_zh-CN.md)

## Scope and reproduction

This experiment starts from commit `4f79b43e27ddddb50acfefd86cbe2a2d7914a184`. The three new full tiles each produce 48 FP32 outputs and have 12 logical SSE accumulators. The implementation uses the existing microkernel template, with one increasing-K accumulation chain per output. The generic increasing-K edge path handles partial M/N tiles, and the outer loop clips the last K panel.

The build uses GCC 15.2.0, x86-64 SSE, Release `-O3 -DNDEBUG`, and separate multiply/add. Only strict libraries are linked in this build. Ryzen 7 7730U under WSL2 Ubuntu was pinned to logical CPU 4. Cache-blocked and register-blocked variants use 128×128×128 outer blocks throughout.

```bash
cmake -S . -B build-microtile-search -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DMINI_GPU_BUILD_MICROTILE_SEARCH=ON
cmake --build build-microtile-search -j4
ctest --test-dir build-microtile-search --output-on-failure
python3 benchmarks/run_microtile_search.py build-microtile-search /tmp/microtile-reproduction --cpu 4
```

Two independent processes per shape each collect nine shuffled rounds after three warm-up calls per configuration. Inputs use seed 20260825 and order seeds are 20261111 and 20261112. All variants share the same input and buffers. Allocation, reference calculation and verification occur outside the timed interval. Kernel time includes output zeroing. One sample batches seven calls at 128³ and one elsewhere. Each paired comparison matches the pass and round. Speedup is baseline time divided by candidate time. The win rate is the fraction of the 18 paired samples that ran faster than the baseline. Per-pass ratios are medians of the nine paired speedups.

[Environment](environment.json) · [Compile commands](compile_commands.json) · [Raw timings](timing_samples.csv) · [Timing summary](timing_summary.csv) · [All relative gains and paired win rates](relative_gains.csv) · [Raw PMU](pmu_samples.csv) · [PMU commands](perf_log.txt) · [Disassembly](disassembly/)

Check the saved results offline from the repository root.

```bash
python3 benchmarks/verify_microtile_search.py
```

## Correctness

The strict suite checks 19 square sizes, the three requested rectangles, and five existing cancellation probes in both their original shape and an expanded 8×16 output. All nine configurations match strict ikj bit for bit across 288 comparisons and 3,437,559 output elements, including repeated checks across configurations. Ordinary inputs pass the unchanged double-reference tolerance. The cancellation differences are also present in strict ikj. The numerical CSV includes bitwise, absolute, relative, and ULP results for every configuration. [Numerical results](numerics.csv)

| Input group | Comparisons | Max absolute vs reference | Max relative vs reference | Max ULP vs reference | Oracle tolerance failures |
|:---|---:|---:|---:|---:|---:|
| Ordinary | 198 | 2.09808349609e-05 | 0.213145585737 | 2,855,949 | 0 |
| Cancellation | 90 | 2047 | 0.99951171875 | 92,274,688 | 4,644 |

## Structure and disassembly

Per K step, 3×16 reuses each A broadcast across four B vectors and each B vector across three rows. 4×12 uses three and four, respectively. 6×8 uses two and six. At a full 128×128 output block, 3×16 and 6×8 leave two rows for the tail path. 4×12 leaves eight columns. Rectangles and ragged outer blocks change these fractions.

The accumulator column counts logical vector chains. The stack columns count actual vector reloads (including memory operands on `addps`) and stores inside the backward K branch. Stack bytes list saved-register pushes plus explicit reservation. Red-zone slots below `rsp` are shown by the operands rather than the explicit reservation. The compiler emits `movss` plus `shufps` for A broadcasts and `movups` for B loads. The listed K loops contain no vector access based on `rbp`.

| Tile | C vector chains | A broadcasts | B vector loads | mulps / addps | K loop | Saved + reserved bytes | Stack reloads / stores |
|:---|---:|---:|---:|:---|:---|:---|:---|
| 4×8 | 8 | 4 | 2 | 8 / 8 | 0x110–0x18a | 40 + 0 | 0 / 0 |
| 3×16 | 12 | 3 | 4 | 12 / 12 | 0xc00–0xcb0 | 48 + 0 | 2 / 2 |
| 4×12 | 12 | 4 | 3 | 12 / 12 | 0xdb0–0xe60 | 48 + 0 | 1 / 1 |
| 6×8 | 12 | 6 | 2 | 12 / 12 | 0xf70–0x1037 | 48 + 0 | 0 / 0 |
| 4×16 | 16 | 4 | 4 | 16 / 16 | 0x2c0–0x3c7 | 48 + 32 | 6 / 6 |

For 3×16, instructions at 0xc93 and 0xca3 read and write `-0x28(%rsp)`, with a second slot at `-0x18(%rsp)`. For 4×12, 0xe4d and 0xe58 read and write `-0x28(%rsp)`. For 4×16, 0x2e2 and 0x2e8 read and write `-0x78(%rsp)`, one of six slots. The 6×8 K loop holds all twelve accumulators in registers. Its saved general-purpose registers do not imply vector spilling.

## Full kernel timing grid

Each cell is **median ms [P10–P90] / GFLOP/s**. `ikj` is the original strict kernel, and `cache` is the strict 128³ cache-blocked kernel. The 8×16 pressure control runs only at 1024³. All 1,404 samples are retained.

| M×N×K | ikj | cache | 4x8 | 3x16 | 4x12 | 6x8 | 4x16 | 8x16 |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 128×128×128 | 0.173 [0.161–0.201] / 24.26 | 0.177 [0.166–0.233] / 23.64 | 0.111 [0.107–0.124] / 37.70 | 0.139 [0.131–0.158] / 30.13 | 0.171 [0.161–0.234] / 24.46 | 0.114 [0.109–0.124] / 36.94 | 0.108 [0.102–0.132] / 38.92 | — |
| 255×255×255 | 1.455 [1.360–1.891] / 22.79 | 1.567 [1.458–2.133] / 21.16 | 1.095 [1.067–1.286] / 30.29 | 1.246 [1.191–1.379] / 26.61 | 1.473 [1.371–1.621] / 22.52 | 1.109 [1.032–1.262] / 29.90 | 1.079 [1.003–1.351] / 30.75 | — |
| 256×256×256 | 1.215 [1.199–1.401] / 27.62 | 1.303 [1.269–1.703] / 25.75 | 0.993 [0.947–1.026] / 33.80 | 1.063 [1.044–1.281] / 31.56 | 1.329 [1.308–1.387] / 25.25 | 0.922 [0.901–1.283] / 36.41 | 0.816 [0.789–0.898] / 41.13 | — |
| 257×257×257 | 1.461 [1.416–1.562] / 23.23 | 1.661 [1.631–1.797] / 20.44 | 1.182 [1.144–1.304] / 28.72 | 1.293 [1.266–1.479] / 26.25 | 1.576 [1.542–1.713] / 21.54 | 1.149 [1.124–1.340] / 29.55 | 1.085 [1.050–1.219] / 31.28 | — |
| 511×511×511 | 14.417 [12.448–15.311] / 18.51 | 14.552 [12.816–16.607] / 18.34 | 9.812 [9.231–10.595] / 27.20 | 10.292 [9.562–10.751] / 25.93 | 12.023 [11.423–12.640] / 22.20 | 9.046 [8.647–10.083] / 29.50 | 8.433 [7.896–9.283] / 31.65 | — |
| 512×512×512 | 12.441 [12.007–13.988] / 21.58 | 12.795 [11.851–13.582] / 20.98 | 9.517 [9.179–10.048] / 28.21 | 9.840 [9.337–10.330] / 27.28 | 12.513 [11.900–13.140] / 21.45 | 8.909 [8.439–9.314] / 30.13 | 7.816 [7.321–8.291] / 34.34 | — |
| 513×513×513 | 15.206 [14.399–17.092] / 17.76 | 15.931 [15.068–18.879] / 16.95 | 12.140 [11.422–13.832] / 22.24 | 11.614 [10.659–13.893] / 23.25 | 14.151 [13.446–15.934] / 19.08 | 10.812 [10.248–12.199] / 24.97 | 9.588 [8.863–11.361] / 28.16 | — |
| 1024×1024×1024 | 119.394 [105.413–136.906] / 17.99 | 123.024 [114.802–138.205] / 17.46 | 91.966 [87.847–104.026] / 23.35 | 88.576 [82.954–107.412] / 24.24 | 116.729 [110.601–137.674] / 18.40 | 91.607 [80.006–101.130] / 23.44 | 75.082 [69.476–85.568] / 28.60 | 74.225 [66.504–87.193] / 28.93 |
| 511×1024×512 | 26.965 [25.411–29.432] / 19.87 | 29.002 [26.917–31.665] / 18.48 | 23.569 [22.610–25.325] / 22.73 | 21.440 [20.205–23.244] / 24.99 | 29.377 [28.340–31.816] / 18.24 | 20.802 [20.035–22.737] / 25.76 | 18.429 [17.628–19.999] / 29.07 | — |
| 1024×511×512 | 35.182 [33.365–42.699] / 15.23 | 35.852 [32.971–40.151] / 14.95 | 23.940 [22.787–25.304] / 22.38 | 25.863 [23.931–29.690] / 20.72 | 29.857 [28.903–35.568] / 17.95 | 23.020 [21.803–25.966] / 23.28 | 21.224 [20.289–24.132] / 25.25 | — |
| 513×1025×257 | 17.316 [15.906–20.021] / 15.61 | 19.938 [17.177–23.275] / 13.56 | 14.844 [13.911–15.859] / 18.21 | 13.776 [11.827–15.341] / 19.62 | 17.492 [15.989–20.033] / 15.45 | 13.859 [12.949–16.303] / 19.50 | 11.215 [10.000–13.009] / 24.10 | — |

## Paired comparison of the new tiles

Each comparison shows **ratio of medians / paired wins out of 18**. The CSV includes these comparisons for every control too, plus separate paired medians for both passes.

| M×N×K | Tile | ikj | 4x8 | 4x16 |
|---:|---:|---:|---:|---:|
| 128×128×128 | 3x16 | 1.242 / 17 | 0.799 / 1 | 0.774 / 1 |
| 128×128×128 | 4x12 | 1.008 / 8 | 0.649 / 0 | 0.629 / 0 |
| 128×128×128 | 6x8 | 1.523 / 18 | 0.980 / 6 | 0.949 / 3 |
| 255×255×255 | 3x16 | 1.167 / 17 | 0.878 / 1 | 0.865 / 3 |
| 255×255×255 | 4x12 | 0.988 / 8 | 0.744 / 0 | 0.732 / 2 |
| 255×255×255 | 6x8 | 1.312 / 18 | 0.987 / 12 | 0.973 / 6 |
| 256×256×256 | 3x16 | 1.143 / 15 | 0.934 / 0 | 0.767 / 0 |
| 256×256×256 | 4x12 | 0.914 / 2 | 0.747 / 0 | 0.614 / 0 |
| 256×256×256 | 6x8 | 1.318 / 16 | 1.077 / 12 | 0.885 / 1 |
| 257×257×257 | 3x16 | 1.130 / 18 | 0.914 / 1 | 0.839 / 1 |
| 257×257×257 | 4x12 | 0.927 / 2 | 0.750 / 0 | 0.689 / 0 |
| 257×257×257 | 6x8 | 1.272 / 17 | 1.029 / 12 | 0.945 / 5 |
| 511×511×511 | 3x16 | 1.401 / 18 | 0.953 / 4 | 0.819 / 0 |
| 511×511×511 | 4x12 | 1.199 / 18 | 0.816 / 0 | 0.701 / 0 |
| 511×511×511 | 6x8 | 1.594 / 18 | 1.085 / 14 | 0.932 / 2 |
| 512×512×512 | 3x16 | 1.264 / 18 | 0.967 / 7 | 0.794 / 0 |
| 512×512×512 | 4x12 | 0.994 / 10 | 0.761 / 0 | 0.625 / 0 |
| 512×512×512 | 6x8 | 1.397 / 18 | 1.068 / 17 | 0.877 / 0 |
| 513×513×513 | 3x16 | 1.309 / 18 | 1.045 / 14 | 0.825 / 0 |
| 513×513×513 | 4x12 | 1.075 / 14 | 0.858 / 0 | 0.678 / 0 |
| 513×513×513 | 6x8 | 1.406 / 18 | 1.123 / 18 | 0.887 / 0 |
| 1024×1024×1024 | 3x16 | 1.348 / 17 | 1.038 / 14 | 0.848 / 0 |
| 1024×1024×1024 | 4x12 | 1.023 / 7 | 0.788 / 1 | 0.643 / 0 |
| 1024×1024×1024 | 6x8 | 1.303 / 18 | 1.004 / 12 | 0.820 / 0 |
| 511×1024×512 | 3x16 | 1.258 / 18 | 1.099 / 17 | 0.860 / 1 |
| 511×1024×512 | 4x12 | 0.918 / 2 | 0.802 / 0 | 0.627 / 0 |
| 511×1024×512 | 6x8 | 1.296 / 18 | 1.133 / 18 | 0.886 / 1 |
| 1024×511×512 | 3x16 | 1.360 / 18 | 0.926 / 2 | 0.821 / 0 |
| 1024×511×512 | 4x12 | 1.178 / 17 | 0.802 / 0 | 0.711 / 0 |
| 1024×511×512 | 6x8 | 1.528 / 18 | 1.040 / 11 | 0.922 / 2 |
| 513×1025×257 | 3x16 | 1.257 / 18 | 1.078 / 15 | 0.814 / 0 |
| 513×1025×257 | 4x12 | 0.990 / 10 | 0.849 / 0 | 0.641 / 0 |
| 513×1025×257 | 6x8 | 1.249 / 18 | 1.071 / 13 | 0.809 / 0 |

## Hardware counters

Three independent process trials per case. Counts are millions per kernel call, except IPC, which is the median of the per-process ratios. Initialization and checksum contribute to the counts. The nine events all report 100% running time. Load and store dispatches are AMD dispatch events. Generic cache events retain their perf names.

| Size | Tile | Cycles | Instructions | IPC | L1D loads | L1D load misses | Cache references | Cache misses | Load dispatch | Store dispatch | Frontend stalls |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 512 | 4x8 | 37.376 | 142.107 | 3.802 | 26.685 | 7.875 | 19.316 | 6.306 | 26.368 | 0.597 | 0.307 |
| 512 | 3x16 | 38.696 | 136.463 | 3.527 | 28.235 | 6.389 | 15.700 | 6.113 | 27.812 | 6.711 | 0.263 |
| 512 | 4x12 | 48.780 | 161.899 | 3.319 | 32.040 | 6.490 | 15.337 | 4.880 | 31.552 | 5.422 | 0.321 |
| 512 | 6x8 | 34.975 | 142.754 | 4.082 | 25.782 | 5.869 | 14.357 | 5.101 | 25.220 | 1.283 | 0.263 |
| 512 | 4x16 | 30.810 | 135.459 | 4.397 | 30.895 | 4.909 | 12.939 | 4.978 | 30.443 | 13.404 | 0.180 |
| 1024 | 4x8 | 342.645 | 1149.011 | 3.353 | 214.639 | 63.292 | 156.374 | 50.823 | 211.436 | 5.308 | 2.411 |
| 1024 | 3x16 | 325.870 | 1103.862 | 3.387 | 227.013 | 52.089 | 132.055 | 49.517 | 223.003 | 54.211 | 1.995 |
| 1024 | 4x12 | 440.105 | 1307.347 | 2.971 | 257.373 | 53.026 | 124.594 | 35.914 | 253.061 | 43.935 | 2.338 |
| 1024 | 6x8 | 323.533 | 1154.190 | 3.567 | 207.421 | 47.387 | 111.114 | 39.248 | 202.362 | 10.803 | 2.001 |
| 1024 | 4x16 | 266.614 | 1095.829 | 4.110 | 248.361 | 41.546 | 107.896 | 38.239 | 244.113 | 107.760 | 1.467 |

## Decision and limitations

None of the new tiles replaces 4×16. All pass strict correctness and reduce or eliminate spilling, but each loses all 18 pairs to 4×16 at both 512 and 1024. The paired median speedups relative to 4×16 in the two passes were:

| Tile | 512 pass 1 | 512 pass 2 | 1024 pass 1 | 1024 pass 2 |
|:---|---:|---:|---:|---:|
| 3×16 | 0.792 | 0.805 | 0.826 | 0.829 |
| 4×12 | 0.614 | 0.629 | 0.616 | 0.600 |
| 6×8 | 0.856 | 0.869 | 0.854 | 0.827 |

6×8 was fastest among the three new shapes in nine of the eleven cases. 3×16 led among the new shapes at 1024³ and 513×1025×257. 4×16 beat every new candidate by median on all three rectangles. This does not support a shape-based dispatch rule for the new candidates on the tested grid. At 1024³ the 8×16 pressure control had a slightly lower median (74.225 vs 75.082 ms) and won 12 of 18 paired rounds. It was tested at just one shape.

For 512 and 1024, 4×16 retires fewer total instructions, has higher IPC, and uses fewer cycles than each new candidate. The larger tile spreads the same K-loop branch and pointer updates across 64 outputs instead of 48. It also uses fewer A broadcasts per output than 4×12 or 6×8. Together with operand reuse and independent output chains, that amortization is consistent with the measured advantage despite the extra spill traffic. The counters do not isolate each contribution.

At 1024, 6×8 reduces store dispatches from 107.760M to 10.803M versus 4×16, while cycles rise from 266.614M to 323.533M and instructions from 1,095.829M to 1,154.190M. PMU supports the reduction in store traffic, while the assembly establishes which stack traffic disappears. Per output, 6×8 requires more A broadcasts than 4×16 and fewer B loads. The experiment does not separate broadcast cost, loop scheduling, and tail cost. In particular, 4×12 has an eight-column remainder in every complete 128-column block. The impact of that remainder is a hypothesis, since the outer block was held fixed.

Retain 4×16 as the current candidate on this strict SSE grid. Keep 6×8 as a spill-free comparison for future work. The scope is Ryzen 7 7730U, WSL2, GCC 15.2.0, strict SSE, and 128³ outer tiles. Native, AVX2, FMA, other CPUs, and size 2048 are outside this experiment. Absolute times drift between experiment runs, including the earlier register-blocking study. Use the interleaved, paired comparisons within this run for performance conclusions. Process-level PMU counts include initialization and checksum. Kernel-only timing determines the performance ranking.
