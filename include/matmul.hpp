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

}  // namespace mini_gpu
