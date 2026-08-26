#include "matmul.hpp"

#include <algorithm>
#include <stdexcept>

namespace mini_gpu {

void matmul_cpu_ikj(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    // The output matrix has no elements, so no pointer is accessed.
    if (M == 0 || N == 0) {
        return;
    }

    // The output matrix contains M*N elements, so C must be writable.
    if (C == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_ikj: C must not be null when M and N are positive"
        );
    }

    // A dot product of length zero produces zero for every output element.
    if (K == 0) {
        std::fill(C, C + M * N, 0.0F);
        return;
    }

    // A and B must be readable for a non-empty matrix multiplication.
    if (A == nullptr || B == nullptr) {
        throw std::invalid_argument(
            "matmul_cpu_ikj: A and B must not be null when M, N and K are positive"
        );
    }

    // This implementation accumulates partial products directly into C.
    std::fill(C, C + M * N, 0.0F);

    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t k = 0; k < K; ++k) {
            const float a_value = A[i * K + k];

            for (std::size_t j = 0; j < N; ++j) {
                const std::size_t b_index = k * N + j;
                const std::size_t c_index = i * N + j;

                C[c_index] += a_value * B[b_index];
            }
        }
    }
}

}  // namespace mini_gpu
