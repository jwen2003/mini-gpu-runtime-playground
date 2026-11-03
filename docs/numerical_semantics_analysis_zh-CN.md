# 从矩阵乘法到 GPU Kernel 的性能优化分析：数值语义分析

## 1. 目标

本文档研究浮点归约语义怎样限制编译器优化，并评估 native fast-math Transposed Kernel 的性能收益与数值代价。

核心问题不是“fast-math 是否通常够准”，而是：

1. reassociation 改变了什么指令结构？
2. 普通输入上的误差规模如何？
3. 是否存在超过当前联合容差的反例？
4. Runtime 能否在未获得授权时自动选择 fast policy？

## 2. 混合编译结构

全局 fast-math build 会同时改变 reference，因此不能用于独立数值裁决。项目新增默认关闭的实验结构：

```text
matmul_cpu + matmul_reference
→ 严格编译

matmul_fast_math
→ 仅 transposed_b_fast.cpp
→ -O3 -march=native -ffast-math

numerics_test
→ 严格编译
→ 同时调用 strict reference 与 fast kernel
```

该结构保证 fast 选项不会泄漏到 oracle 或比较逻辑。

## 3. 性能机制

严格 Transposed Kernel 虽获得 AVX2 乘法，仍以逐 lane `vaddss` 保持累加顺序，约为 3.56 GFLOP/s。fast-math 允许 reassociation 后，GCC 使用 packed `vaddps` accumulator，只在循环末进行一次 horizontal reduction，吞吐约为 33.8 GFLOP/s。

counter mode 显示：

- instructions 减少约 67.5%；
- cycles 减少约 89.0%；
- L1D loads 和 misses 基本不变；
- IPC 从约 1.08 提高至约 3.20。

因此性能收益来自归约结构，而不是数据布局或缓存行为再次改变。

## 4. 普通输入结果

当前联合容差：

```text
abs(actual - expected) <= 1e-4 + 1e-3 × abs(expected)
```

### 均匀随机 `[-1,1]`

扫描 `K=1–4096`，所有 case 均无 tolerance failure。`K=4096` 的最大绝对误差约 `1.91e-5`。

### 全正 `[0,1]`

所有 case 均无 tolerance failure。`K=4096` 的最大绝对误差约 `3.05e-4`，但最大相对误差约 `3.02e-7`，ULP distance 为 5。

### 高动态范围随机输入

输入指数范围约为 `10^-10–10^10`。`K=4096` 的最大绝对误差约 `3.52e13`，对应结果约 `-1.34e20`，最大相对误差约 `1.46e-6`，ULP distance 为 18，仍满足联合容差。

这些结果表明 fast kernel 对当前普通样例通常接近 strict reference，但不能证明所有输入安全。

## 5. Lane-sensitive 反例

### 单个 8-lane vector

输入项：

```text
1e10, -1e10, 1, 1, 1e10, -1e10, 1, 1
```

结果：

| 指标 | 数值 |
|---|---:|
| strict reference | 4 |
| fast actual | 0 |
| absolute error | 4 |
| relative error | 1 |
| tolerance failures | 1 |

### 重复到 K=4096

| 指标 | 数值 |
|---|---:|
| strict reference | 2048 |
| fast actual | 0 |
| absolute error | 2048 |
| relative error | 1 |
| tolerance failures | 1 |

反例说明误差取决于数值排列与 SIMD lane 分组，而不只是 K 或动态范围。fast reassociation 可以丢失全部小量有效贡献，不只是改变末尾几位。

## 6. 特殊值观察

当前 NaN、正无穷、`Inf×0`、相反无穷、negative zero 和 subnormal 样例未观察到 classification mismatch 或 signed-zero mismatch。

这只描述当前运行时样例，不能外推为 `-ffast-math` 保证 IEEE 特殊值语义。编译器允许作出更强假设，其他表达式、常量传播、平台或链接方式可能产生不同结果。

## 7. 指标解释

- 绝对误差必须结合结果尺度；
- 相对误差在 reference 接近零时可能被放大；
- ULP distance 在跨零或极接近零时可能非常大；
- tolerance failure 用当前 API 契约裁决普通有限值；
- classification mismatch 优先于普通误差指标；
- checksum 相同不代表逐元素或逐 bit 相同。

## 8. 工程决策

### `strict` 是默认数值策略

- Runtime 不得为提高性能而隐式切换到 fast-math；
- 默认 correctness 与特殊值语义保持现有契约；
- 实现选择可以自动化，但不能越过数值授权边界。

### `fast` 必须显式 opt-in

- 调用者明确允许 reassociation；
- 文档必须说明强抵消风险；
- fast policy 与 CPU/GPU、Kernel、tile 等性能 policy 分开；
- 不通过放宽默认容差掩盖 lane-sensitive 反例。

## 9. 适用边界

当前证据来自 AMD Ryzen 7 7730U、GCC 15.2、AVX2/FMA、FP32 row-major Matmul 和当前测试集合。不同编译器、指令集、向量宽度和归约实现可能改变性能及具体反例，但不会消除“reassociation 改变数值语义”这一结构性事实。

## 10. 后续工作

- 修正无误差 case 的 worst-value 显示语义；
- 将样例结果输出为 CSV；
- 增加更系统的 ULP/动态范围统计；
- CUDA 阶段继续区分 strict 与 relaxed reduction；
- Runtime API 显式携带 numerical policy。
