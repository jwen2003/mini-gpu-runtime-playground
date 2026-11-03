# From Matrix Multiplication to GPU Kernels: Numerical Semantics

[简体中文](numerical_semantics_analysis_zh-CN.md) | [English](numerical_semantics_analysis_en.md)

## 1. Goal

Study how floating-point reduction semantics constrain optimization and evaluate the performance and numerical costs of the native fast-math transposed-B kernel. Questions include the instruction structure changed by reassociation, ordinary-input error, counterexamples exceeding the current tolerance, and whether a runtime may select fast policy without authorization.

## 2. Mixed compilation

A global fast-math build also changes the reference and cannot independently adjudicate numerical accuracy. The default-off experiment separates compilation:

```text
matmul_cpu, including matmul_reference: strict compilation
matmul_fast_math: transposed_b_fast.cpp only, -O3 -march=native -ffast-math
numerics_test: strict compilation, calling both reference and fast kernel
```

Fast options do not propagate into the oracle or comparison logic.

## 3. Performance mechanism

The strict transposed-B kernel uses AVX2 multiplication but per-lane vaddss to preserve accumulation order, achieving about 3.56 GFLOP/s. With reassociation, GCC uses packed vaddps accumulation and one final horizontal reduction, reaching about 33.8 GFLOP/s.

Counter mode shows approximately 67.5% fewer instructions, 89.0% fewer cycles, essentially unchanged L1D loads/misses, and IPC increasing from 1.08 to 3.20. The gain comes from reduction structure rather than another layout or cache change.

## 4. Ordinary inputs

```text
abs(actual - expected) <= 1e-4 + 1e-3 × abs(expected)
```

Uniform random [-1,1] cases across K=1–4096 had no tolerance failures; maximum absolute error at K=4096 was about 1.91e-5.

All-positive [0,1] cases had no failures. At K=4096, maximum absolute error was about 3.05e-4, maximum relative error 3.02e-7, and maximum ULP distance 5.

High-dynamic-range random inputs spanned magnitudes about 10^-10–10^10. At K=4096, maximum absolute error was about 3.52e13 for a result around -1.34e20, maximum relative error about 1.46e-6, and ULP distance 18, within tolerance.

These samples show close agreement on ordinary inputs, not safety for all inputs.

## 5. Lane-sensitive counterexample

A single eight-lane input sequence is:

```text
1e10, -1e10, 1, 1, 1e10, -1e10, 1, 1
```

| Metric | K=8 | Repeated to K=4096 |
|---|---:|---:|
| Strict reference | 4 | 2048 |
| Fast actual | 0 | 0 |
| Absolute error | 4 | 2048 |
| Relative error | 1 | 1 |
| Tolerance failures | 1 | 1 |

Error depends on arrangement and SIMD lane grouping, not just K or dynamic range. Reassociation can lose all meaningful small contributions, beyond changing a few final bits.

## 6. Special values

Current NaN, positive infinity, Inf×0, opposite infinities, negative-zero, and subnormal samples showed no classification or signed-zero mismatches. This describes these runtime samples only; fast-math does not thereby guarantee IEEE special-value semantics. Compiler assumptions, other expressions, constant propagation, platforms, or linking can change outcomes.

## 7. Reading the metrics

Interpret absolute error against result scale. Relative error can grow near zero reference results; ULP distance can become very large across or near zero. Tolerance failures apply the current API criterion to ordinary finite values. Classification mismatch takes precedence over ordinary error metrics. Matching checksums do not establish elementwise or bitwise equality.

## 8. Engineering decision

Strict is the default numerical policy. Runtime selection must not silently enable fast-math; preserve the default correctness/special-value contract. Automatic implementation selection cannot cross the numerical authorization boundary.

Fast requires explicit opt-in to reassociation. Document cancellation risk and keep numerical policy separate from CPU/GPU, kernel, and tile performance policies. Do not loosen default tolerances to conceal lane-sensitive counterexamples.

## 9. Applicability

Evidence comes from AMD Ryzen 7 7730U, GCC 15.2, AVX2/FMA, FP32 row-major Matmul, and the current test set. Different compilers, instruction sets, widths, and reductions can change performance and particular counterexamples, but reassociation still changes numerical semantics.

## 10. Future work

Correct worst-value display for zero-error cases; export samples as CSV; add systematic ULP/dynamic-range statistics; preserve strict/relaxed reduction distinctions in the future CUDA stage; and carry numerical policy explicitly in the runtime API.
