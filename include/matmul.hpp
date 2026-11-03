#pragma once

#include <cstddef>

namespace mini_gpu {

void matmul_reference(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

void matmul_cpu_ijk(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

void matmul_cpu_ikj(
    const float* A,
    const float* B,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

void transpose_b(
    const float* B,
    float* B_transposed,
    std::size_t N,
    std::size_t K
);

void matmul_cpu_transposed_b(
    const float* A,
    const float* B_transposed,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

// Experimental implementation. This symbol is available only when
// MINI_GPU_BUILD_FAST_MATH_EXPERIMENT=ON.
void matmul_cpu_transposed_b_fast(
    const float* A,
    const float* B_transposed,
    float* C,
    std::size_t M,
    std::size_t N,
    std::size_t K
);

}  // namespace mini_gpu
