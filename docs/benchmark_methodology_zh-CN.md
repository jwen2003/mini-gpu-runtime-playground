# 从矩阵乘法到 GPU Kernel 的性能优化分析：基准测试方法

[English](benchmark_methodology_en.md) | [简体中文](benchmark_methodology_zh-CN.md)

## 1. 目的

本文档定义项目的正确性与性能测量协议。目标不是消除所有系统噪声，而是使不同实现和不同尺寸之间的比较具有一致、可解释、可复现的口径。

## 2. 构建环境

当前已确认的本地环境：

- CPU：AMD Ryzen 7 7730U；
- 核心：8 cores / 16 threads；
- L1D：每核 32 KiB、8-way、64 sets、64-byte cache line；
- L2：每核 512 KiB、8-way；
- L3：16 MiB shared、16-way；
- 编译器：GCC 15.2；
- 构建类型：Release；
- 已确认编译选项：`-O3 -DNDEBUG`；
- 运行环境：WSL2 Ubuntu。

性能结论必须记录对应平台和编译环境，不默认外推到其他 CPU、编译器或操作系统。

## 3. 正确性基准

### 3.1 Oracle

`matmul_reference` 使用：

- 与被测实现相同的 FP32 输入与输出；
- `double` 中间累加；
- 最终转换为 `float`。

它降低了 reference 自身的累加误差，但不意味着数学上的无限精度，也不保证与改变归约顺序的实现逐 bit 一致。

### 3.2 判定规则

普通有限浮点数使用：

```text
abs(actual - expected) <= atol + rtol × abs(expected)
```

当前值：

- `atol = 1e-4`
- `rtol = 1e-3`

NaN 和 Inf 单独判断，不进入普通联合容差。

### 3.3 测试范围

统一 correctness suite 应覆盖：

- `M=0` 或 `N=0`；
- `K=0`；
- 必要指针为空；
- 方阵与非方阵；
- 小矩阵手工可验证样例；
- 正数、负数、小数和零；
- 固定随机输入；
- 后续所有 CPU 与 CUDA 实现。

## 4. 程序内计时

当前 `measure_operation` 对每个 case 执行：

- 5 次 warm-up；
- 10 次正式测量；
- 每次正式测量使用 `std::chrono::steady_clock`；
- correctness verification 位于计时区间之外；
- checksum 在测量后读取 C，使输出保持可观察。

输出统计量：

- minimum；
- P10；
- median；
- P90；
- maximum；
- GFLOP/s；
- checksum。

Transposed B 提供三种独立计时语义：

- `transposed-kernel`：BT 在计时前生成，只测 Matmul；
- `transpose-only`：BT 预分配，只测 B 到 BT；
- `transposed-e2e`：BT 预分配，每轮包含转置和 Matmul。

`transposed-e2e` 不包含内存分配、随机输入、reference、correctness verification 或输出，因此准确含义是 preallocated transpose + compute，而非全进程端到端延迟。

## 5. 运算量与吞吐

Matmul 的名义浮点运算量按下式计算：

```text
operation_count = 2 × M × N × K
```

其中一次乘法和一次加法分别计作一个浮点操作。当前 GFLOP/s 使用中位延迟：

```text
GFLOP/s = operation_count / (median_ms × 10^6)
```

这是一种统一的算法吞吐口径，不代表 CPU 实际执行的硬件指令条数，也不区分 FMA 是否作为一条指令完成。

transpose-only 使用逻辑带宽：

```text
logical_bytes = 2 × N × K × sizeof(float)
logical_GB/s = logical_bytes / (median_ms × 10^6)
```

它只计一次读取 B 和一次写入 BT，不代表硬件真实流量。`transposed-e2e` 报告 `effective_GFLOP/s`：只计算 Matmul FLOPs，但将转置时间包含在分母中。

## 6. 为什么保留分布而不只看最小值

- minimum 可近似反映低干扰条件下的最好一次，但可能过于乐观；
- median 作为主要报告值，对少量离群值更稳健；
- P10/P90 描述主体波动范围；
- maximum 用于暴露调度、后台负载、温度或频率变化造成的尾部抖动。

不同实验应优先比较同一轮、同一环境下的相对结果。跨轮次的绝对延迟变化不能自动解释为代码性能变化。

## 7. GCC 向量化报告

当前使用以下方式生成临时报告：

```bash
g++ -std=c++17 -O3 -Iinclude \
  -fopt-info-vec-all \
  -c src/cpu/ijk.cpp \
  -o /tmp/matmul_ijk.o \
  2> /tmp/matmul_ijk.vec

g++ -std=c++17 -O3 -Iinclude \
  -fopt-info-vec-all \
  -c src/cpu/ikj.cpp \
  -o /tmp/matmul_ikj.o \
  2> /tmp/matmul_ikj.vec
```

当前报告显示：

- `ijk` 的关键访问存在 `not suitable for strided load`；
- `ikj` 的最内层循环使用 16-byte 和 8-byte vectors；
- `ikj` 因可能的 pointer aliasing 生成运行时 versioned loop。
- 默认 Transposed Kernel 的连续点积使用 16-byte vectors；
- `-march=native` 下 `ikj` 与 Transposed Kernel 均使用 32-byte vectors；
- 向量化成功不代表归约结构高吞吐，必须结合汇编检查 packed/scalar 指令。

向量化报告用于解释编译器决策，不能单独证明缓存行为。

## 8. perf 硬件计数器

专用 counter mode 不运行 reference、不执行程序内计时或 correctness verification，将目标操作重复固定次数：

```bash
perf stat -r 5 \
  -e cycles,instructions,l1-dcache-loads,l1-dcache-load-misses \
  ./build/cpu_benchmark ijk 256 --counter 100
```

`-r 5` 表示独立运行整个进程 5 次，并报告平均值及波动。

主要观察：

- cycles：总执行周期；
- instructions：退休指令数；
- L1D loads：L1 数据缓存 load 访问；
- L1D load misses：L1 数据缓存 load miss；
- L1D miss rate：由 misses / loads 计算。

硬件事件必须与控制变量实验结合。单独看到 miss 数量很高，不能自动确定是哪段代码或哪种访问模式造成。

counter mode 中：

- 输入、输出和 workspace 在重复循环前分配；
- `transposed-kernel` 的 BT 在循环前生成；
- `transpose-only` 和 `transposed-e2e` 在每次循环中执行转置；
- 最后读取一次 checksum；
- 事件总数除以迭代次数，可近似得到 per-call 计数。

## 9. 构建变体

### 默认 Release

```text
-O3 -DNDEBUG
```

用于默认可移植语义和主要结果。

### Native 对照

```text
-O3 -DNDEBUG -march=native
```

用于研究 AVX2/FMA 和向量宽度，不修改默认 build。

### 全局 fast-math 机制实验

```text
-O3 -DNDEBUG -march=native -ffast-math
```

只用于初步性能与汇编对照。由于 reference 也被 fast-math 编译，不能用于独立数值裁决。

### 混合语义 numerics build

默认关闭的 `MINI_GPU_BUILD_FAST_MATH_EXPERIMENT` 建立独立 fast static library。只有 `transposed_b_fast.cpp` 使用 native fast-math；strict reference 和 `numerics_test` 保持严格编译。

## 10. 测量边界与限制

普通计时模式的外层 `perf stat` 会统计整个进程，包括：

- 输入分配与初始化；
- 一次 reference 计算；
- 5 次 warm-up；
- 10 次正式运行；
- correctness verification；
- checksum 与输出。

因此：

- 它适合比较结构接近、外围工作相近的 `ijk@255/256/257`；
- 它不能直接作为纯 matmul kernel 的事件计数；
- 它不适合精确比较耗时相差很大的 `ijk` 与 `ikj`，因为外围代码在快速实现中占比更高；
- 需要硬件事件归因时，应优先使用现有 counter mode。

counter mode 仍会计入进程启动、输入初始化和一次 checksum，但目标 Kernel 重复 100 次后，这些外围开销占比显著降低。它不是精确的指令区间开关。

## 11. 后续测量改进

计划增加：

- 命令行选择 M、N、K、实现、warm-up 和 repeat；
- CSV 输出；
- Git commit、CPU/GPU、编译器、编译选项等元数据；
- CPU affinity 与频率/温度记录；
- CUDA event 计时；
- H2D、Kernel、D2H 分项；
- Nsight Compute 指标；
- 成熟 BLAS/cuBLAS 基线。

所有改进都应服务于一个明确的归因问题，而不是为了增加指标数量。

数值比较程序 `numerics_test` 当前为报告型工具，未注册为 CTest；退出成功表示完成比较，不表示 fast 实现通过严格容差。强抵消用例中的容差失败是已记录的实验结果。
