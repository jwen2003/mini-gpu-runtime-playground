# 从矩阵乘法到 GPU Kernel 的性能优化分析：CPU 内存访问分析

## 1. 分析目标

本阶段研究两个数学等价的 CPU Matmul 实现为何产生显著性能差异，并调查 `cpu_ijk` 在 `N=256` 出现的特殊性能低谷。

分析采用以下证据链：

```text
观察循环顺序差异
→ 提出缓存与 SIMD 假设
→ 扫描相邻尺寸
→ 固定 M/K 隔离 N
→ 查询 cache geometry
→ 检查 GCC 向量化报告
→ 使用 perf 验证 L1D 事件
```

## 2. 两种循环顺序

### 2.1 `i-j-k`

核心访问可抽象为：

```cpp
for (i)
    for (j)
        for (k)
            C[i * N + j] += A[i * K + k] * B[k * N + j];
```

内层 k 变化时：

- A 连续访问；
- B 每次跨越 N 个 `float`；
- C 的一个元素通常在寄存器中完成归约后写回。

### 2.2 `i-k-j`

核心访问可抽象为：

```cpp
for (i)
    for (k)
        for (j)
            C[i * N + j] += A[i * K + k] * B[k * N + j];
```

内层 j 变化时：

- `A[i * K + k]` 可被复用；
- B 连续访问；
- C 连续访问；
- C 需要在不同 k 迭代中被反复更新。

## 3. 初始性能观察

在 `M=N=K=256` 的早期实验中，`ikj` 的中位延迟约为 1.2–1.6 ms，`ijk` 约为 19–22 ms。两者 checksum 一致并通过统一 correctness verification。

该结果说明循环重排带来显著收益，但单独的时间差不能区分缓存访问、SIMD、编译器代码生成和特殊尺寸效应。

## 4. 特殊尺寸实验

### 4.1 初步扫描

首先比较接近的方阵尺寸 `255/256/257`。`ijk@256` 的延迟接近相邻尺寸两倍，而 `ikj` 没有出现同类低谷。

### 4.2 隔离 N

为避免同时改变 M、N、K，后续固定：

```text
M = 256
K = 256
```

只扫描：

```text
N = 248, 252, 255, 256, 257, 260, 264
```

代表性结果：

| N | `cpu_ijk` GFLOP/s |
|---:|---:|
| 248 | 3.20 |
| 252 | 3.19 |
| 255 | 3.13 |
| 256 | **1.69** |
| 257 | 3.13 |
| 260 | 3.18 |
| 264 | 3.21 |

### 已确认事实

- 除 256 外，`ijk` 基本稳定在约 3.1–3.2 GFLOP/s；
- `N=256` 降至约 1.69 GFLOP/s；
- M 与 K 保持不变；
- 因此，异常与由 N 决定的访问结构高度相关，而不是单纯由计算量增加造成。

## 5. Cache geometry 与映射推导

Ryzen 7 7730U 的 L1D 参数：

| 参数 | 数值 |
|---|---:|
| 容量 | 32 KiB / core |
| Cache line | 64 bytes |
| Sets | 64 |
| Associativity | 8-way |

在 `ijk` 内层，B 的相邻访问地址差为：

```text
stride_bytes = N × sizeof(float)
```

当 `N=256`：

```text
stride_bytes = 256 × 4 = 1024 bytes
stride_lines = 1024 / 64 = 16 cache lines
```

L1D 有 64 sets，因此理想化的 set index 每次增加 16：

```text
0 → 16 → 32 → 48 → 0 → ...
```

这意味着一列 B 的规则访问集中循环使用少量 sets。长度为 256 的点积会让每个相关 set 面对远多于 8 条的竞争 cache line，具备产生严重 conflict miss 的条件。

`N=255/257` 打破这一规则二次幂步长，使访问分散到更多 sets。

### 证据状态

上述映射是基于 row-major 地址公式和公开可查询 cache geometry 的机制推导。它需要硬件计数器观察到相应的 L1D miss 激增，才能形成更强归因。

## 6. 编译器向量化证据

GCC 15.2、`-O3` 的 vectorization report 显示：

### `ijk`

```text
not vectorized: not suitable for strided load
```

这说明 B 的跨步 load 阻碍关键循环形成理想的连续向量访问。

报告中也存在一条 16-byte vectorization 成功记录，因此不能表述为“整个 `ijk` 完全没有 SIMD”。准确结论是：关键的跨步 B load 是向量化障碍。

### `ikj`

```text
loop vectorized using 16 byte vectors
loop vectorized using 8 byte vectors
loop versioned for vectorization because of possible aliasing
```

这表明内层连续循环得到 SIMD 向量化；同时因为接口没有向编译器明确表达 A、B、C 不重叠，GCC 生成运行时 alias check 和不同执行路径。

### 证据边界

编译器报告支持“连续访问提供更直接的 SIMD 机会”，但不能单独证明 `N=256` 的缓存冲突。

## 7. perf 控制变量实验

分别隔离运行：

```bash
./build/cpu_benchmark ijk 255
./build/cpu_benchmark ijk 256
./build/cpu_benchmark ijk 257
```

并使用：

```bash
perf stat -r 5 \
  -e cycles,instructions,l1-dcache-loads,l1-dcache-load-misses \
  ./build/cpu_benchmark ijk N
```

结果如下：

| 指标 | N=255 | N=256 | N=257 |
|---|---:|---:|---:|
| Cycles | 763,293,396 | **1,396,785,486** | 770,428,024 |
| Instructions | 1,522,166,792 | 1,528,120,554 | 1,534,064,540 |
| L1D loads | 340,769,280 | 339,806,194 | 343,598,688 |
| L1D load misses | 23,054,299 | **278,445,240** | 25,748,970 |
| L1D miss rate | 6.77% | **81.94%** | 7.49% |
| 进程 elapsed time | 0.1875 s | **0.3424 s** | 0.1888 s |

相对 `N=255`：

- `N=256` instructions 只增加约 0.39%；
- L1D loads 减少约 0.28%；
- L1D load misses 增加到约 12.1 倍；
- cycles 增加到约 1.83 倍。

相对 `N=257`，结论同样成立：工作量指标接近，但 `N=256` 的 L1D misses 与 cycles 显著增加。

## 8. 当前结论

### 已确认事实

1. `cpu_ijk` 在 `N=256` 存在可复现的特殊性能低谷；
2. 相邻的 `N=255/257` 不存在同等低谷；
3. `N=256` 的 instructions 和 L1D loads 与相邻尺寸基本相同；
4. `N=256` 的 L1D load miss rate 从约 7% 上升至约 82%；
5. miss 激增与 cycles 增加和 GFLOP/s 下降同步发生；
6. `ijk` 的关键 B 访问是 strided load，`ikj` 的内层连续循环得到明确向量化。

### 机制归因

当前证据支持以下因果解释：

```text
N=256
→ B 的内层访问形成 1024-byte stride
→ 以 16 cache lines 为步长循环映射
→ 访问集中到少量 L1D sets
→ 超过 8-way 容量并产生 conflict misses
→ L1D miss rate 激增
→ cycles 增加、吞吐下降
```

这一归因同时受到地址公式、cache geometry、相邻尺寸控制实验和 L1D 硬件事件支持，强度明显高于单纯根据时间差进行猜测。

## 9. 适用边界与限制

当前结论适用于：

- AMD Ryzen 7 7730U；
- 当前 WSL2 环境；
- GCC 15.2；
- `-O3 -DNDEBUG`；
- FP32 row-major；
- 当前 `cpu_ijk` 实现；
- 固定 `M=K=256` 的实验条件。

不应直接外推为：

- 所有二次幂矩阵尺寸都一定更慢；
- 所有 CPU 都会出现相同幅度；
- 所有 cache 层级均发生同一映射行为；
- `ikj` 在所有尺寸和平台上都具有相同加速比；
- 当前外层 `perf` 数据等同于纯 kernel 事件。

外层 `perf` 仍计入初始化、一次 reference、warm-up、验证和输出。不过对 `ijk@255/256/257` 而言，外围流程一致、目标实现结构接近，且硬件事件差异远大于测量波动，因此足以支持本轮控制变量归因。

## 10. 下一阶段假设

下一实现为显式转置 B：

```text
B[K][N] → B_transposed[N][K]
```

转置后，原本按列访问 B 的点积可以连续读取 `B_transposed[j][k]`。

需要分别测量：

1. 仅 matmul kernel，不包含转置；
2. 单次 matmul 的转置加计算总成本；
3. 同一个转置结果被多次复用时的摊销成本；
4. `N=255/256/257` 的异常是否消失；
5. 编译器向量化是否改善；
6. L1D miss rate 是否下降；
7. 与 `ikj` 相比，减少 C 反复更新是否足以抵消转置成本。

完成转置实验后，再进入 cache blocking 和 block-size sweep。
