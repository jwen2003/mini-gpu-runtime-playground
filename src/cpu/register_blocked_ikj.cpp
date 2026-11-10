#include "register_experiment.hpp"

#include <algorithm>
#include <stdexcept>
#include <xmmintrin.h>

namespace mini_gpu {
namespace {

template <std::size_t Rows, std::size_t Columns>
[[gnu::noinline]] void microkernel(
    const float* A, const float* B, float* C,
    std::size_t N, std::size_t K, std::size_t depth
) {
    __m128 accumulators[Rows][Columns / 4];
#pragma GCC unroll 8
    for (std::size_t i = 0; i < Rows; ++i) {
#pragma GCC unroll 4
        for (std::size_t v = 0; v < Columns / 4; ++v) {
            accumulators[i][v] = _mm_loadu_ps(C + i * N + v * 4);
        }
    }

    // Each lane represents a different output. There is one accumulation
    // chain per output, in K order, and no reduction between lanes.
    for (std::size_t k = 0; k < depth; ++k) {
        __m128 b[Columns / 4];
#pragma GCC unroll 4
        for (std::size_t v = 0; v < Columns / 4; ++v) {
            b[v] = _mm_loadu_ps(B + k * N + v * 4);
        }
#pragma GCC unroll 8
        for (std::size_t i = 0; i < Rows; ++i) {
            const __m128 a = _mm_set1_ps(A[i * K + k]);
#pragma GCC unroll 4
            for (std::size_t v = 0; v < Columns / 4; ++v) {
                accumulators[i][v] = _mm_add_ps(
                    accumulators[i][v], _mm_mul_ps(a, b[v])
                );
            }
        }
    }

#pragma GCC unroll 8
    for (std::size_t i = 0; i < Rows; ++i) {
#pragma GCC unroll 4
        for (std::size_t v = 0; v < Columns / 4; ++v) {
            _mm_storeu_ps(C + i * N + v * 4, accumulators[i][v]);
        }
    }
}

template <std::size_t Rows, std::size_t Columns>
void tiled(
    const float* A, const float* B, float* C,
    std::size_t M, std::size_t N, std::size_t K,
    std::size_t BM, std::size_t BN, std::size_t BK
) {
    for (std::size_t ii = 0; ii < M;) {
        const auto i_end = ii + std::min(BM, M - ii);
        for (std::size_t jj = 0; jj < N;) {
            const auto j_end = jj + std::min(BN, N - jj);
            // Spill-free tiles keep C in registers for this K panel.
            // Storing between panels preserves the original increasing K order.
            for (std::size_t kk = 0; kk < K;) {
                const auto k_end = kk + std::min(BK, K - kk);
                for (std::size_t i = ii; i < i_end;) {
                    const auto rows = std::min(Rows, i_end - i);
                    for (std::size_t j = jj; j < j_end;) {
                        const auto columns = std::min(Columns, j_end - j);
                        if (rows == Rows && columns == Columns) {
                            microkernel<Rows, Columns>(
                                A + i * K + kk, B + kk * N + j, C + i * N + j,
                                N, K, k_end - kk
                            );
                        } else {
                            for (std::size_t row = i; row < i + rows; ++row) {
                                for (std::size_t k = kk; k < k_end; ++k) {
                                    const float a = A[row * K + k];
                                    for (std::size_t col = j; col < j + columns; ++col) {
                                        C[row * N + col] += a * B[k * N + col];
                                    }
                                }
                            }
                        }
                        j += columns;
                    }
                    i += rows;
                }
                kk = k_end;
            }
            jj = j_end;
        }
        ii = i_end;
    }
}

}  // namespace

void matmul_cpu_register_blocked_ikj(
    const float* A, const float* B, float* C,
    std::size_t M, std::size_t N, std::size_t K,
    std::size_t BM, std::size_t BN, std::size_t BK, RegisterTile tile
) {
    if (BM == 0 || BN == 0 || BK == 0) {
        throw std::invalid_argument("register blocking requires positive block sizes");
    }
    if (M == 0 || N == 0) {
        return;
    }
    if (C == nullptr || (K != 0 && (A == nullptr || B == nullptr))) {
        throw std::invalid_argument("register blocking requires non-null matrix buffers");
    }

    std::fill(C, C + M * N, 0.0F);
    if (K == 0) {
        return;
    }

    switch (tile) {
    case RegisterTile::r2c8:  tiled<2, 8>(A, B, C, M, N, K, BM, BN, BK); return;
    case RegisterTile::r4c8:  tiled<4, 8>(A, B, C, M, N, K, BM, BN, BK); return;
    case RegisterTile::r4c16: tiled<4, 16>(A, B, C, M, N, K, BM, BN, BK); return;
    case RegisterTile::r8c16: tiled<8, 16>(A, B, C, M, N, K, BM, BN, BK); return;
    }
    throw std::invalid_argument("unsupported register tile");
}

}  // namespace mini_gpu
