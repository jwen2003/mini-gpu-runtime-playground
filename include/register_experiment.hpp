#pragma once

#include "matmul.hpp"

namespace mini_gpu {

// Only built by MINI_GPU_BUILD_REGISTER_EXPERIMENT. The fast entry points
// require an AllowReassociation policy from the caller.
enum class RegisterTile { r2c8, r4c8, r4c16, r8c16 };

void matmul_cpu_register_blocked_ikj(
    const float*, const float*, float*, std::size_t, std::size_t, std::size_t,
    std::size_t, std::size_t, std::size_t, RegisterTile
);
void matmul_cpu_register_blocked_ikj_fast(
    const float*, const float*, float*, std::size_t, std::size_t, std::size_t,
    std::size_t, std::size_t, std::size_t, RegisterTile
);
void matmul_cpu_ikj_fast(
    const float*, const float*, float*, std::size_t, std::size_t, std::size_t
);
void matmul_cpu_blocked_ikj_fast(
    const float*, const float*, float*, std::size_t, std::size_t, std::size_t,
    std::size_t, std::size_t, std::size_t
);

}  // namespace mini_gpu
