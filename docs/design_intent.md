# Matmul CPU Baseline — Design Intent

## 1. 目标

建立一个行为明确、可重复验证的 FP32 矩阵乘法基线，为后续 CPU 循环顺序优化、CUDA Kernel、Runtime 调度与硬件性能分析提供统一参照。

本阶段不追求最高性能，优先保证：

- 接口语义明确；
- 内存布局统一；
- corner case 行为确定；
- 正确性可以独立验证；
- 不同实现使用同一套测量协议。

## 2. 数学定义

计算：

C = A × B

其中：

- A 的尺寸为 M×K；
- B 的尺寸为 K×N；
- C 的尺寸为 M×N；
- C[i][j] 等于 A 第 i 行与 B 第 j 列的点积。

## 3. 数据类型

- A、B、C 的存储类型均为 float。
- reference 使用 double 中间累加，最后转换为 float。
- CPU 性能版本和后续基础 CUDA Kernel 使用 float 累加。
- reference 的主要职责是提供正确性 oracle，而不是充当性能基线。

## 4. 内存布局

所有矩阵均采用 row-major 连续存储。

二维坐标对应的一维下标：

- A[i][k] → A[i × K + k]
- B[k][j] → B[k × N + j]
- C[i][j] → C[i × N + j]

A、B、C 的有效内存范围不得重叠。V0 不执行运行时重叠检测，由调用者保证此前置条件。

## 5. 输出语义

函数采用覆盖语义：

C = A × B

调用前 C 中的旧值不得影响结果。V0 不支持 alpha、beta 或 C 累加语义。

## 6. 尺寸与指针行为

### M=0 或 N=0

输出矩阵没有任何元素：

- 函数直接返回；
- 不访问 A、B、C；
- A、B、C 允许为空指针。

### M>0、N>0、K=0

输出矩阵 C 非空，但每个元素的归约项数为 0：

- C 必须是有效指针；
- 将 C 的全部 M×N 个元素写为 0；
- A 和 B 不会被读取，因此允许为空指针。

### M>0、N>0、K>0

- A、B、C 都必须是有效指针；
- 任一必要指针为空时，抛出 std::invalid_argument。

## 7. 第一阶段实现

### matmul_reference

- 循环顺序：i-j-k；
- double 累加；
- 最终写回 float；
- 作为正确性 oracle。

### matmul_cpu_ijk

- 循环顺序：i-j-k；
- float 累加；
- 一个 C 元素完成后写回一次。

### matmul_cpu_ikj

- 循环顺序：i-k-j；
- float 累加；
- 调用开始时将 C 清零；
- 复用 A[i][k]；
- 在最内层连续访问 B 的一行和 C 的一行。

## 8. 初始性能假设

在 row-major 布局下：

- i-j-k 连续访问 A，但按 stride=N 访问 B；
- i-k-j 连续访问 B 和 C，并可复用 A[i][k]；
- i-k-j 需要反复更新 C。

初始假设是：对足够大的矩阵，i-k-j 的连续访问和数据复用收益可能超过反复更新 C 的成本。

这只是待验证假设，不是既定结论。

## 9. 正确性判定

普通有限浮点数采用联合容差：

abs(actual - expected) <= atol + rtol × abs(expected)

初始值：

- atol = 1e-4
- rtol = 1e-3

另外单独检查：

- NaN；
- 正负无穷；
- 非法指针；
- 零尺寸行为。

## 10. 明确不做

V0 不包括：

- 多线程 CPU 实现；
- SIMD intrinsics；
- cache blocking；
- CUDA；
- cuBLAS；
- alpha/beta GEMM 语义；
- 输入输出内存重叠支持；
- 针对特定 CPU 的手工汇编优化。
