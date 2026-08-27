# 从矩阵乘法到 GPU Kernel 的性能优化分析

本项目以 FP32 row-major 矩阵乘法为唯一核心算子，研究同一数学计算在不同循环顺序、缓存访问、编译器向量化、CUDA Kernel 与 Runtime 调度策略下的性能差异。

项目重点不是堆叠实现数量，也不以单一加速比作为结论，而是建立可复现、可证伪的性能分析闭环：

```text
接口与数值语义
→ 正确性基准
→ 性能假设
→ 控制变量实验
→ 编译器与硬件计数器验证
→ 新实现与权衡
→ Runtime 选择规则
```

## 当前状态

已完成：

- FP32 row-major Matmul 统一接口；
- 使用 double 中间累加的 correctness oracle；
- `i-j-k` CPU 基线；
- `i-k-j` CPU 循环重排版本；
- corner case 与固定随机测试；
- warm-up、重复测量、分位数、GFLOP/s 和 checksum；
- GCC 向量化报告分析；
- 固定 `M=K=256`、扫描 N 的缓存异常实验；
- 使用 `perf` 对 `N=255/256/257` 进行 L1D 硬件计数器验证。

待完成：

- 显式转置 B 的 CPU 实现与转置成本分析；
- cache-blocked CPU 实现与 block-size sweep；
- 与成熟 BLAS 基线比较；
- CUDA naive、coalesced、shared-memory tiled 和 register-tiled Kernel；
- kernel-only 与端到端传输成本分离；
- 基于实测 crossover point 的最小 Runtime dispatch。

## 已实现接口

当前 CPU 实现：

- `matmul_reference`：`i-j-k`，double 中间累加，作为 correctness oracle；
- `matmul_cpu_ijk`：`i-j-k`，float 累加；
- `matmul_cpu_ikj`：`i-k-j`，float 累加，连续访问 B 和 C。

所有实现遵循相同的尺寸、指针、内存布局和覆盖写回语义。详细契约见：

- [`docs/design_intent_zh-CN.md`](docs/design_intent_zh-CN.md)

## 构建与测试

```bash
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build
ctest --test-dir build --output-on-failure
```

当前 CPU benchmark 每次接收一个实现和一个 N，M 与 K 固定为 256：

```bash
./build/cpu_benchmark ijk 255
./build/cpu_benchmark ijk 256
./build/cpu_benchmark ikj 256
```

硬件计数器示例：

```bash
perf stat -r 5 \
  -e cycles,instructions,l1-dcache-loads,l1-dcache-load-misses \
  ./build/cpu_benchmark ijk 256
```

测量协议、统计口径和已知限制见：

- [`docs/benchmark_methodology_zh-CN.md`](docs/benchmark_methodology_zh-CN.md)

## 当前关键发现

在 AMD Ryzen 7 7730U、GCC 15.2、`-O3` 环境下，固定 `M=K=256` 后，`cpu_ijk` 在 `N=256` 出现可复现的特殊性能低谷。

与 `N=255/257` 相比：

- instructions 和 L1D loads 基本不变；
- L1D load miss rate 从约 7% 上升至约 82%；
- cycles 增加约 83%；
- GFLOP/s 接近减半。

结合 32 KiB、64-set、8-way、64-byte cache line 的 L1D 几何结构，当前证据支持以下归因：`N=256` 使 B 的内层访问形成 1024-byte stride，并集中映射到少量 cache sets，产生严重 conflict misses。

完整数据、推导、证据强度和适用边界见：

- [`docs/cpu_memory_access_analysis_zh-CN.md`](docs/cpu_memory_access_analysis_zh-CN.md)

## 文档索引

- [`docs/design_intent_zh-CN.md`](docs/design_intent_zh-CN.md)：目标、接口契约、范围与完成标准；
- [`docs/benchmark_methodology_zh-CN.md`](docs/benchmark_methodology_zh-CN.md)：正确性与性能测量协议；
- [`docs/cpu_memory_access_analysis_zh-CN.md`](docs/cpu_memory_access_analysis_zh-CN.md)：CPU 循环顺序、SIMD 与 L1D 异常分析。

## 项目边界

本项目不扩展到卷积、Attention、Softmax、FFT 或完整深度学习框架。最终仍围绕一个 Matmul 算子，贯通 CPU cache、编译器 SIMD、GPU memory hierarchy、Kernel launch 和 Runtime dispatch。

项目不以击败 OpenBLAS、Eigen 或 cuBLAS 为目标；成熟库用于定位手写实现的剩余差距。
