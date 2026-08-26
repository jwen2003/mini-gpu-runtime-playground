#include "matmul.hpp"

#include <algorithm>
#include <stdexcept>

namespace mini_gpu {

void matmul_reference(
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
            "matmul_reference: C must not be null when M and N are positive"
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
            "matmul_reference: A and B must not be null when M, N and K are positive"
        );
    }

    for (std::size_t i = 0; i < M; ++i) {
        for (std::size_t j = 0; j < N; ++j) {
            double sum = 0.0;

            for (std::size_t k = 0; k < K; ++k) {
                const std::size_t a_index = i * K + k;
                const std::size_t b_index = k * N + j;

                sum += static_cast<double>(A[a_index])
                     * static_cast<double>(B[b_index]);
            }

            const std::size_t c_index = i * N + j;
            C[c_index] = static_cast<float>(sum);
        }
    }
}

}  // namespace mini_gpu
