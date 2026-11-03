# mini-gpu-runtime-playground

[English](README.md) | [简体中文](README_zh-CN.md)

可重复验证的 FP32 行主序矩阵乘法实验平台，研究内存访问、编译器优化和数值策略，为后续最小运行时提供依据。

## 已实现内容

严格 double 累加 reference、float `ijk`、`ikj`、`transpose_b`、严格转置 B 内核、正确性测试、CPU 基准测试、隔离 fast-math 实验及数值比较工具。

Blocked/Tiled Matmul 为 **planned（计划中）**；CUDA 与运行时调度属于后续工作。

## 构建与运行

需要 CMake 3.20+、C++17；可选实验要求 GCC/Clang。基准参数选择实现和 N，M=K=256。端到端计时包含预分配缓冲区上的转置与计算。counter 模式排除 reference 和正确性验证，但进程级计数仍包含初始化。

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

## 关键结果与数值策略

已有数据来自 AMD Ryzen 7 7730U、WSL2、GCC 15.2、Release（`-O3 -DNDEBUG`）。`ijk` 在 N=256 出现 cache-set conflict；转置 B 消除了 255/256/257 中的特殊低谷，但严格浮点语义下水平归约和依赖链仍使转置内核慢于 `ikj`。native 汇编与 perf 支持这一归因，而非剩余 L1D miss 主导。

native fast-math 机制实验使用 `-march=native -ffast-math`，性能数值仅适用于对应机器。隔离数值构建仅对 `transposed_b_fast.cpp` 使用 `-O3 -march=native -ffast-math`，reference 和比较程序保持严格编译。数值验证不得添加全局 fast-math 选项。

随机、全正、动态范围输入报告绝对误差、相对误差和 ULP distance。lane-sensitive 序列 `[1e10, -1e10, 1, 1, 1e10, -1e10, 1, 1]` 已观察到 strict reference 为 4、fast 为 0；重复至 K=4096 时分别为 2048 和 0。这些是特定编译器和平台上的观察。`numerics_test` 是报告工具，退出成功不代表符合 strict 容差。

fast-math 默认关闭，仅供实验。未来运行时必须由显式 numerical policy 允许重结合，不能仅凭矩阵尺寸自动选择 fast kernel。

## 文档索引

详细数据、编译选项、计时边界和局限保留于中文分析文档：

- [Design / 设计](docs/design_intent_zh-CN.md)
- [Methodology / 测量方法](docs/benchmark_methodology_zh-CN.md)
- [CPU analysis / CPU 分析](docs/cpu_memory_access_analysis_zh-CN.md)
- [Numerical semantics / 数值语义](docs/numerical_semantics_analysis_zh-CN.md)
