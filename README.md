# mini-gpu-runtime-playground

[English](README.md) | [简体中文](README_zh-CN.md)

A reproducible FP32 row-major matrix multiplication playground studying memory access, compiler optimization, and numerical policy before a minimal runtime.

## Implementations

Implemented: strict double-accumulating reference, float `ijk`, `ikj`, `transpose_b`, strict transposed-B kernel, correctness tests, CPU benchmark, isolated fast-math experiment, and numerical comparison tool.

Blocked/Tiled Matmul is **planned**. CUDA and runtime dispatch are future work.

## Build and run

Requires CMake 3.20+, C++17, and GCC/Clang for the optional experiment. Benchmark arguments select the implementation and N; M=K=256. End-to-end timing includes transpose and compute with preallocated buffers. Counter mode excludes reference and verification, but process-level counters still include setup.

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
ctest --test-dir build --output-on-failure
./build/cpu_benchmark ijk 256
./build/cpu_benchmark ikj 256
./build/cpu_benchmark transposed-kernel 256
./build/cpu_benchmark transpose-only 256
./build/cpu_benchmark transposed-e2e 256
./build/cpu_benchmark transposed-kernel 256 --counter 100
cmake -S . -B build-numerics -DCMAKE_BUILD_TYPE=Release -DMINI_GPU_BUILD_FAST_MATH_EXPERIMENT=ON
cmake --build build-numerics -j
./build-numerics/numerics_test
```

## Key results and numerical policy

Existing measurements on AMD Ryzen 7 7730U, WSL2, GCC 15.2, Release (`-O3 -DNDEBUG`) show an `ijk` cache-set conflict at N=256. Transposing B removes the special 255/256/257 trough, but strict floating-point semantics retain a horizontal reduction dependency chain; the transposed-B kernel remains slower than `ikj`. Native assembly and perf support this attribution rather than remaining L1D misses.

The native fast-math mechanism experiment used `-march=native -ffast-math`; its performance is machine-specific. The isolated numerical build applies `-O3 -march=native -ffast-math` only to `transposed_b_fast.cpp`, preserving the strict reference and comparison tool. Never add global fast-math flags for numerical validation.

Random, positive, and dynamic-range cases report absolute error, relative error, and ULP distance. The lane-sensitive sequence `[1e10, -1e10, 1, 1, 1e10, -1e10, 1, 1]` produced strict reference 4 versus fast 0; repeated to K=4096, 2048 versus 0. These are observed compiler/platform results. `numerics_test` is a reporting tool: exit success does not assert strict tolerance compliance.

Fast-math is experimental and disabled by default. A future runtime must require an explicit numerical policy allowing reassociation; matrix size alone cannot authorize a fast kernel.

## Documentation

Detailed evidence, options, timing boundaries, and limitations are maintained in Chinese:

- [Design / 设计](docs/design_intent_zh-CN.md)
- [Methodology / 测量方法](docs/benchmark_methodology_zh-CN.md)
- [CPU analysis / CPU 分析](docs/cpu_memory_access_analysis_zh-CN.md)
- [Numerical semantics / 数值语义](docs/numerical_semantics_analysis_zh-CN.md)
