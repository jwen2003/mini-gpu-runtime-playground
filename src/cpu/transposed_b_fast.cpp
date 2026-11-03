#include "matmul.hpp"

#include <algorithm>
#include <stdexcept>

namespace mini_gpu {

void matmul_cpu_transposed_b_fast(
    const float* A,
    const float* B_transposed,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    if (M == 0 || N == 0) {
        return;
    }

    if (C == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_transposed_b_fast: C must not be null when M and N are positive"
        );
    }

    if (K == 0) {
        std::fill(C, C + M * N, 0.0F);
        return;
    }

    if (A == nullptr || B_transposed == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_transposed_b_fast: A and B_transposed must not be null when M, N and K are positive"
        );
    }

    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t j = 0; j < N; ++j) {
            float sum = 0.0F;

            for (std::size_t k = 0; k < K; ++k) {
                sum += A[i * K + k]
                     * B_transposed[j * K + k];
            }

            C[i * N + j] = sum;
        }
    }
}

}  // namespace mini_gpu
