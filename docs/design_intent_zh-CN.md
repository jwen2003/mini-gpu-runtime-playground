# 从矩阵乘法到 GPU Kernel 的性能优化分析：设计意图

## 1. 目标

建立一个行为明确、可重复验证的 FP32 矩阵乘法实验平台，从 CPU 基线逐步扩展到 CUDA Kernel 与最小 Runtime 调度，并形成从程序访问模式到硬件性能现象的可验证因果链。

项目优先保证：

- 接口语义明确；
- 内存布局统一；
- corner case 行为确定；
- 正确性可以独立验证；
- 不同实现使用一致的测量协议；
- 性能结论可以由控制变量实验、编译器报告或硬件计数器支持；
- 已确认事实、机制归因和待验证假设相互区分。

项目不以实现数量、单个峰值数据或最高绝对性能作为主要完成标准。

## 2. 数学定义

计算：

```text
C = A × B
```

其中：

- A 的尺寸为 `M × K`；
- B 的尺寸为 `K × N`；
- C 的尺寸为 `M × N`；
- `C[i][j]` 等于 A 第 i 行与 B 第 j 列的点积。

## 3. 数据类型与数值角色

- A、B、C 的存储类型均为 `float`；
- reference 使用 `double` 中间累加，最后转换为 `float`；
- CPU 性能版本和初始 CUDA Kernel 使用 `float` 累加；
- reference 的职责是提供 correctness oracle，而不是充当性能竞争基线；
- 不同归约顺序可能产生合法的浮点舍入差异，因此正确性不要求逐 bit 相等。

## 4. 内存布局

所有矩阵均采用 row-major 连续存储。

二维坐标对应的一维下标为：

- `A[i][k] → A[i × K + k]`
- `B[k][j] → B[k × N + j]`
- `C[i][j] → C[i × N + j]`

A、B、C 的有效内存范围不得重叠。当前版本不执行运行时重叠检测，由调用者保证此前置条件。

## 5. 输出语义

函数采用覆盖语义：

```text
C = A × B
```

调用前 C 中的旧值不得影响结果。当前版本不支持 `alpha`、`beta` 或 C 累加语义。

## 6. 尺寸与指针行为

### 6.1 `M=0` 或 `N=0`

输出矩阵没有元素：

- 函数直接返回；
- 不访问 A、B、C；
- A、B、C 允许为空指针。

### 6.2 `M>0`、`N>0`、`K=0`

输出矩阵 C 非空，但归约项数为 0：

- C 必须是有效指针；
- 将 C 的全部 `M × N` 个元素写为 0；
- A 和 B 不会被读取，因此允许为空指针。

### 6.3 `M>0`、`N>0`、`K>0`

- A、B、C 都必须是有效指针；
- 任一必要指针为空时，抛出 `std::invalid_argument`。

## 7. 当前已实现版本

### 7.1 `matmul_reference`

- 循环顺序：`i-j-k`；
- `double` 中间累加；
- 最终转换并写回 `float`；
- 作为 correctness oracle。

### 7.2 `matmul_cpu_ijk`

- 循环顺序：`i-j-k`；
- `float` 累加；
- 一个 C 元素完成归约后写回一次；
- 在 row-major B 上形成以 N 为元素跨度的内层访问。

### 7.3 `matmul_cpu_ikj`

- 循环顺序：`i-k-j`；
- `float` 累加；
- 调用开始时将 C 清零；
- 复用 `A[i][k]`；
- 在最内层连续访问 B 的一行和 C 的一行。

三个版本均接入统一 correctness test 和 CPU benchmark，并遵守相同的接口、布局、输出和异常语义。

## 8. 性能研究问题

项目研究以下问题：

1. 循环顺序怎样改变缓存局部性和编译器向量化机会？
2. 特定矩阵尺寸是否会因 cache-set mapping 出现异常性能低谷？
3. 连续访问带来的收益是否超过反复更新 C 的成本？
4. 显式转置 B 和 cache blocking 分别解决什么瓶颈，又引入什么成本？
5. CUDA 中线程映射、coalescing、shared-memory reuse 和 register tiling 如何改变性能？
6. kernel-only 与包含内存传输的端到端测量为什么可能得出不同结论？
7. Runtime 的 CPU/GPU 与 Kernel 选择规则能否由实测数据产生？

前两个问题已经完成第一轮实验验证，详见 `cpu_memory_access_analysis_zh-CN.md`。其余问题仍待后续实现和测量。

## 9. 正确性判定

普通有限浮点数采用联合容差：

```text
abs(actual - expected) <= atol + rtol × abs(expected)
```

当前默认值：

- `atol = 1e-4`
- `rtol = 1e-3`

此外单独处理或检查：

- NaN；
- 正负无穷；
- 非法指针；
- 零尺寸行为；
- 方阵与非方阵；
- 固定随机输入。

容差必须由数值误差模型和测试证据约束，不能为了让失败用例通过而任意放宽。

## 10. 项目演进范围

项目最终仍只围绕 FP32 row-major Matmul 展开，不通过增加算子数量扩大规模。

计划中的实现层次包括：

- CPU reference；
- CPU `i-j-k`；
- CPU `i-k-j`；
- 显式转置 B；
- cache-blocked CPU 实现；
- 少量具有明确性能假设的 CUDA Kernel；
- 根据矩阵尺寸、数据位置和实测结果选择实现的最小 Runtime dispatch。

每增加一个实现，都必须说明：

- 针对的瓶颈；
- 改变的数据访问或执行结构；
- 引入的额外成本；
- 正确性验证方式；
- 性能假设；
- 支持或否定假设的测量证据；
- 结论适用的硬件和软件环境。

## 11. 完成标准

项目完成时应形成以下闭环：

- 所有实现通过统一 correctness suite；
- CPU 与 GPU benchmark 可重复运行并输出结构化结果；
- CPU 优化由 cache、SIMD 和硬件计数器证据解释；
- CUDA 优化由 memory hierarchy、occupancy、寄存器和 profiler 证据解释；
- Runtime dispatch 规则来自实测 crossover point，而非任意硬编码；
- 明确区分 kernel-only 与 end-to-end 性能；
- 明确记录反例、收益递减和硬件相关性；
- 其他人可以依据仓库命令复现实验。

## 12. 明确不做

当前项目不包括：

- 完整深度学习框架；
- 自动微分；
- 多 GPU 或分布式执行；
- 完整编译器；
- 通用 CUDA Runtime 替代品；
- 以多线程 CPU 为主的扩展；
- 大量数据类型和算子支持；
- `alpha/beta` GEMM 完整语义；
- 输入输出内存重叠支持；
- 针对特定 CPU 的手工汇编；
- 以击败成熟 BLAS 或 cuBLAS 为目标。
