#include "matmul.hpp"

#include <algorithm>
#include <stdexcept>

namespace mini_gpu {

void matmul_cpu_blocked_ikj(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K,
    std::size_t BM,
    std::size_t BN,
    std::size_t BK
) {
    if (BM == 0 || BN == 0 || BK == 0) {
        throw std::invalid_argument("blocked ikj requires positive block sizes");
    }
    if (M == 0 || N == 0) {
        return;
    }
    if (C == nullptr || (K != 0 && (A == nullptr || B == nullptr))) {
        throw std::invalid_argument("blocked ikj requires non-null matrix buffers");
    }

    std::fill(C, C + M * N, 0.0F);
    if (K == 0) {
        return;
    }

    // Keep working on one C tile across K panels. Advance each bound by
    // its remaining extent so the last tile is clipped without overflow.
    for (std::size_t ii = 0; ii < M;) {
        const std::size_t i_end = ii + std::min(BM, M - ii);
        for (std::size_t jj = 0; jj < N;) {
            const std::size_t j_end = jj + std::min(BN, N - jj);
            // Increasing kk and k preserves each output's FP32 accumulation
            // order. The inner j loop updates contiguous elements of B and C.
            for (std::size_t kk = 0; kk < K;) {
                const std::size_t k_end = kk + std::min(BK, K - kk);
                for (std::size_t i = ii; i < i_end; ++i) {
                    for (std::size_t k = kk; k < k_end; ++k) {
                        const float a_value = A[i * K + k];
                        for (std::size_t j = jj; j < j_end; ++j) {
                            C[i * N + j] += a_value * B[k * N + j];
                        }
                    }
                }
                kk = k_end;
            }
            jj = j_end;
        }
        ii = i_end;
    }
}

}  // namespace mini_gpu
