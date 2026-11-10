#pragma once

#include <cstddef>
#include <vector>

namespace mini_gpu::test {

template <typename RunCase>
void run_cancellation_cases(RunCase run_case) {
    constexpr std::size_t M = 1;
    constexpr std::size_t N = 1;
    constexpr std::size_t K = 4096;

    std::vector<float> B(K, 1.0F);

    std::vector<float> alternating(K);
    for (std::size_t k = 0; k < K; ++k) {
        alternating[k] = k % 2 == 0 ? 1.0F : -1.0F;
    }
    run_case(
        "alternating_cancellation",
        alternating,
        B,
        M,
        N,
        K
    );

    std::vector<float> magnitude_mixed(K, 1.0F);
    for (std::size_t k = 0; k + 3 < K; k += 4) {
        magnitude_mixed[k] = 1.0e10F;
        magnitude_mixed[k + 1] = 1.0F;
        magnitude_mixed[k + 2] = -1.0e10F;
        magnitude_mixed[k + 3] = 1.0F;
    }
    run_case(
        "magnitude_mixed_cancellation",
        magnitude_mixed,
        B,
        M,
        N,
        K
    );

    {
        const std::vector<float> lane_sensitive = {
            1.0e10F, -1.0e10F, 1.0F, 1.0F,
            1.0e10F, -1.0e10F, 1.0F, 1.0F
        };
        const std::vector<float> unit_b(8, 1.0F);
        run_case(
            "lane_sensitive_single_vector",
            lane_sensitive,
            unit_b,
            M,
            N,
            8
        );
    }

    {
        std::vector<float> lane_sensitive_repeated(K);
        for (std::size_t k = 0; k < K; k += 8) {
            lane_sensitive_repeated[k] = 1.0e10F;
            lane_sensitive_repeated[k + 1] = -1.0e10F;
            lane_sensitive_repeated[k + 2] = 1.0F;
            lane_sensitive_repeated[k + 3] = 1.0F;
            lane_sensitive_repeated[k + 4] = 1.0e10F;
            lane_sensitive_repeated[k + 5] = -1.0e10F;
            lane_sensitive_repeated[k + 6] = 1.0F;
            lane_sensitive_repeated[k + 7] = 1.0F;
        }
        run_case(
            "lane_sensitive_repeated",
            lane_sensitive_repeated,
            B,
            M,
            N,
            K
        );
    }

    {
        const std::vector<float> small_between_large = {
            1.0e10F, 1.0F, 1.0F, 1.0F,
            -1.0e10F, 1.0F, 1.0F, 1.0F
        };
        const std::vector<float> unit_b(8, 1.0F);
        run_case(
            "small_terms_between_large",
            small_between_large,
            unit_b,
            M,
            N,
            8
        );
    }
}

}  // namespace mini_gpu::test
