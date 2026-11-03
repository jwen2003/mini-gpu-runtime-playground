# From Matrix Multiplication to GPU Kernels: Design Intent

[简体中文](design_intent_zh-CN.md) | [English](design_intent_en.md)

## 1. Goal

Build an FP32 matrix multiplication playground with explicit behavior and reproducible validation, progressing from CPU baselines toward CUDA kernels and minimal runtime dispatch. Establish a verifiable causal chain from access patterns to hardware performance.

Priorities are clear interface semantics, consistent layouts, deterministic corner cases, independent correctness validation, consistent measurement protocols, and performance conclusions supported by controlled experiments, compiler reports, or hardware counters. Distinguish confirmed facts, mechanism attribution, and untested hypotheses. Implementation count and isolated peak performance are not the completion criteria.

## 2. Mathematical definition

Compute `C = A × B`, where A is `M × K`, B is `K × N`, and C is `M × N`. Each `C[i][j]` is the dot product of row i of A and column j of B.

## 3. Types and numerical roles

A, B, and C store `float`. The reference accumulates in `double` and converts the result to `float`. CPU performance implementations, and the intended initial CUDA kernels, use float accumulation. The reference is a correctness oracle rather than a performance competitor. Different reduction orders can produce legitimate rounding differences; correctness does not require bitwise equality.

## 4. Memory layout

Matrices use contiguous row-major storage:

- `A[i][k] → A[i × K + k]`
- `B[k][j] → B[k × N + j]`
- `C[i][j] → C[i × N + j]`

The valid memory ranges of A, B, and C must not overlap. The caller guarantees this precondition; the current implementation does not detect overlap at runtime.

## 5. Output semantics

Functions overwrite C with `A × B`. Previous C values must not affect the result. The current interface does not support alpha, beta, or accumulation into an existing C.

## 6. Dimensions and pointers

### 6.1 M=0 or N=0

Return immediately without accessing A, B, or C. All pointers may be null.

### 6.2 M>0, N>0, K=0

C must be valid. Write zero to all `M × N` output elements. A and B are not read and may be null.

### 6.3 M>0, N>0, K>0

All required pointers must be valid. A null required pointer causes `std::invalid_argument`.

## 7. Implemented versions

### 7.1 matmul_reference

Uses i-j-k order and double accumulation, converts to float on writeback, and serves as the correctness oracle.

### 7.2 matmul_cpu_ijk

Uses i-j-k order and float accumulation. Each C element is written once after reduction. Inner-loop B accesses have a stride of N elements.

### 7.3 matmul_cpu_ikj

Uses i-k-j order and float accumulation. Clears C at entry, reuses `A[i][k]`, and accesses rows of B and C contiguously in the innermost loop.

### 7.4 transpose_b and matmul_cpu_transposed_b

`transpose_b` converts row-major `B[K][N]` into row-major `BT[N][K]`, with `BT[j × K + k] = B[k × N + j]`. The transposed-B kernel accepts BT rather than the original B. Its inner k loop reads both A and BT contiguously. Measure transpose and kernel costs separately.

### 7.5 matmul_cpu_transposed_b_fast

Built only with `MINI_GPU_BUILD_FAST_MATH_EXPERIMENT=ON`, in a separate static library using `-O3 -march=native -ffast-math`. The strict reference, default CPU implementations, and comparison program do not inherit fast-math. This experiment studies the performance and numerical cost of reassociation; it is outside default semantics.

Default implementations participate in correctness tests. The transposed version preserves output and exception semantics, but its second input is BT, so its input contract differs from kernels accepting B.

## 8. Performance questions

1. How does loop order affect locality and vectorization?
2. Can cache-set mapping cause a trough at particular dimensions?
3. Does contiguous access outweigh repeated C updates?
4. Which bottlenecks do explicit transposition and cache blocking address, and what costs do they introduce?
5. How do CUDA thread mapping, coalescing, shared-memory reuse, and register tiling affect performance?
6. Why can kernel-only and end-to-end measurements including transfers differ?
7. Can measured data determine runtime CPU/GPU and kernel selection?

The first three questions and the transposition part of question four have initial experimental evidence. Cache blocking is planned and unimplemented. See [CPU analysis](cpu_memory_access_analysis_en.md) and [numerical semantics](numerical_semantics_analysis_en.md). Remaining questions require future implementation and measurement.

## 9. Numerical policy

Separate numerical policy from performance policy. `strict` is the default: a runtime must not silently enable fast-math, the oracle uses double accumulation, and implementations must satisfy explicit tolerances and special-value rules without requiring bitwise equality.

`fast` requires explicit opt-in to reassociation and packed SIMD accumulation. It can improve performance within the current tolerance on ordinary inputs, but does not guarantee strict results under cancellation, unusual arrangements, or other corner cases. A runtime may select it only when the caller permits relaxed numerical semantics. Existing counterexamples turn nonzero reference results into zero; increasing default tolerances must not conceal this difference.

## 10. Correctness criteria

For ordinary finite values:

```text
abs(actual - expected) <= atol + rtol × abs(expected)
atol = 1e-4
rtol = 1e-3
```

Handle or check NaN, positive and negative infinity, invalid pointers, zero dimensions, square and rectangular matrices, and deterministic random inputs separately. Tolerances must follow error models and evidence, rather than being loosened to pass failures.

## 11. Evolution scope

Keep FP32 row-major Matmul as the only operator. The implementation progression comprises the CPU reference, i-j-k, i-k-j, explicit B transposition, planned cache-blocked CPU code, a small set of CUDA kernels with explicit performance hypotheses, and minimal dispatch based on dimensions, data location, and measurements.

Each added implementation must document its target bottleneck, changed access or execution structure, additional costs, correctness checks, performance hypothesis, supporting or contradictory measurements, and applicable hardware/software environment.

## 12. Completion criteria

- Unified correctness validation for implementations.
- Reproducible CPU/GPU benchmarks with structured output.
- CPU optimization explained by cache, SIMD, and counters.
- CUDA optimization explained by memory hierarchy, occupancy, registers, and profiling.
- Dispatch based on measured crossover points rather than arbitrary constants.
- Explicit kernel-only and end-to-end boundaries.
- Documented counterexamples, diminishing returns, and hardware dependence.
- Separate implementation selection and numerical policy.
- Commands enabling others to reproduce experiments.

## 13. Out of scope

A full deep-learning framework, automatic differentiation, multi-GPU/distributed execution, a full compiler, a general CUDA runtime replacement, primarily multithreaded CPU expansion, many operators or data types, full alpha/beta GEMM semantics, overlapping buffers, CPU-specific handwritten assembly, and competing with mature BLAS or cuBLAS are outside scope.
