#include "matmul.hpp"

#include <algorithm>
#include <stdexcept>

namespace mini_gpu {

void transpose_b(
    const float* B,
    float* B_transposed,
    std::size_t N,
    std::size_t K
) {
    // B and B_transposed contain no elements when either dimension is zero.
    if (N == 0 || K == 0) {
        return;
    }

    if (B == nullptr || B_transposed == nullptr) {
        throw std::invalid_argument(
            "transpose_b: B and B_transposed must not be null when N and K are positive"
        );
    }

    for (std::size_t k = 0; k < K; ++k) {
        for (std::size_t j = 0; j < N; ++j) {
            B_transposed[j * K + k] = B[k * N + j];
        }
    }
}

void matmul_cpu_transposed_b(
    const float* A,
    const float* B_transposed,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    // The output matrix has no elements, so no pointer is accessed.
    if (M == 0 || N == 0) {
        return;
    }

    if (C == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_transposed_b: C must not be null when M and N are positive"
        );
    }

    // A dot product of length zero produces zero for every output element.
    if (K == 0) {
        std::fill(C, C + M * N, 0.0F);
        return;
    }

    if (A == nullptr || B_transposed == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_transposed_b: A and B_transposed must not be null when M, N and K are positive"
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
