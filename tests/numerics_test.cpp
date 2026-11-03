#include "matmul.hpp"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <limits>
#include <random>
#include <string>
#include <vector>

namespace {

constexpr float absolute_tolerance = 1.0e-4F;
constexpr float relative_tolerance = 1.0e-3F;

struct ErrorSummary {
    double maximum_absolute_error = 0.0;
    double maximum_relative_error = 0.0;
    std::size_t tolerance_failures = 0;
    std::size_t classification_mismatches = 0;
    std::size_t signed_zero_mismatches = 0;
    std::uint64_t maximum_ulp_distance = 0;
    std::size_t worst_absolute_error_index = 0;
    float worst_actual_value = 0.0F;
    float worst_expected_value = 0.0F;
};

std::uint32_t ordered_float_bits(float value) {
    std::uint32_t bits = 0;
    static_assert(sizeof(bits) == sizeof(value));
    std::memcpy(&bits, &value, sizeof(bits));

    if ((bits & 0x80000000U) != 0U) {
        return 0x80000000U - (bits & 0x7fffffffU);
    }

    return 0x80000000U + bits;
}

std::uint64_t ulp_distance(float first, float second) {
    const std::uint32_t first_ordered = ordered_float_bits(first);
    const std::uint32_t second_ordered = ordered_float_bits(second);

    return first_ordered >= second_ordered
        ? static_cast<std::uint64_t>(first_ordered - second_ordered)
        : static_cast<std::uint64_t>(second_ordered - first_ordered);
}

ErrorSummary compare_outputs(
    const std::vector<float>& actual,
    const std::vector<float>& expected
) {
    ErrorSummary summary;

    for (std::size_t index = 0; index < actual.size(); ++index) {
        const float actual_value = actual[index];
        const float expected_value = expected[index];

        const bool actual_nan = std::isnan(actual_value);
        const bool expected_nan = std::isnan(expected_value);
        const bool actual_inf = std::isinf(actual_value);
        const bool expected_inf = std::isinf(expected_value);

        if (
            actual_nan != expected_nan
            || actual_inf != expected_inf
            || (
                actual_inf
                && expected_inf
                && std::signbit(actual_value) != std::signbit(expected_value)
            )
        ) {
            ++summary.classification_mismatches;
            continue;
        }

        if (actual_nan || actual_inf) {
            continue;
        }

        if (
            actual_value == 0.0F
            && expected_value == 0.0F
            && std::signbit(actual_value) != std::signbit(expected_value)
        ) {
            ++summary.signed_zero_mismatches;
        }

        const double absolute_error = std::fabs(
            static_cast<double>(actual_value)
            - static_cast<double>(expected_value)
        );
        const double denominator = std::max(
            std::fabs(static_cast<double>(expected_value)),
            static_cast<double>(std::numeric_limits<float>::min())
        );
        const double relative_error = absolute_error / denominator;

        if (absolute_error > summary.maximum_absolute_error) {
            summary.maximum_absolute_error = absolute_error;
            summary.worst_absolute_error_index = index;
            summary.worst_actual_value = actual_value;
            summary.worst_expected_value = expected_value;
        }
        summary.maximum_relative_error = std::max(
            summary.maximum_relative_error,
            relative_error
        );
        summary.maximum_ulp_distance = std::max(
            summary.maximum_ulp_distance,
            ulp_distance(actual_value, expected_value)
        );

        const double allowed_error =
            static_cast<double>(absolute_tolerance)
            + static_cast<double>(relative_tolerance)
            * std::fabs(static_cast<double>(expected_value));

        if (absolute_error > allowed_error) {
            ++summary.tolerance_failures;
        }
    }

    return summary;
}

void print_summary(
    const std::string& case_name,
    std::size_t K,
    const ErrorSummary& summary
) {
    std::cout
        << "case=" << case_name
        << ", K=" << K
        << ", max_abs_error=" << summary.maximum_absolute_error
        << ", max_rel_error=" << summary.maximum_relative_error
        << ", max_ulp_distance=" << summary.maximum_ulp_distance
        << ", tolerance_failures=" << summary.tolerance_failures
        << ", classification_mismatches="
        << summary.classification_mismatches
        << ", signed_zero_mismatches="
        << summary.signed_zero_mismatches
        << ", worst_index=" << summary.worst_absolute_error_index
        << ", worst_actual=" << summary.worst_actual_value
        << ", worst_expected=" << summary.worst_expected_value
        << '\n';
}

ErrorSummary run_case(
    const std::string& case_name,
    const std::vector<float>& A,
    const std::vector<float>& B,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    std::vector<float> B_transposed(N * K);
    std::vector<float> expected(M * N);
    std::vector<float> actual(M * N);

    mini_gpu::transpose_b(
        B.data(), B_transposed.data(), N, K
    );
    mini_gpu::matmul_reference(
        A.data(), B.data(), expected.data(), M, N, K
    );
    mini_gpu::matmul_cpu_transposed_b_fast(
        A.data(), B_transposed.data(), actual.data(), M, N, K
    );

    const ErrorSummary summary = compare_outputs(actual, expected);
    print_summary(case_name, K, summary);
    return summary;
}

void run_random_k_sweep() {
    constexpr std::size_t M = 7;
    constexpr std::size_t N = 9;
    constexpr std::size_t k_values[] = {
        1, 3, 7, 16, 31, 64, 127, 256, 511, 1024, 4096
    };

    std::mt19937 generator(20260827);
    std::uniform_real_distribution<float> distribution(-1.0F, 1.0F);

    for (const std::size_t K : k_values) {
        std::vector<float> A(M * K);
        std::vector<float> B(K * N);
        for (float& value : A) {
            value = distribution(generator);
        }
        for (float& value : B) {
            value = distribution(generator);
        }
        run_case("random_uniform", A, B, M, N, K);
    }
}

void run_positive_k_sweep() {
    constexpr std::size_t M = 3;
    constexpr std::size_t N = 5;
    constexpr std::size_t k_values[] = {16, 64, 256, 1024, 4096};

    std::mt19937 generator(20260828);
    std::uniform_real_distribution<float> distribution(0.0F, 1.0F);

    for (const std::size_t K : k_values) {
        std::vector<float> A(M * K);
        std::vector<float> B(K * N);
        for (float& value : A) {
            value = distribution(generator);
        }
        for (float& value : B) {
            value = distribution(generator);
        }
        run_case("all_positive", A, B, M, N, K);
    }
}

void run_cancellation_cases() {
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

void run_dynamic_range_cases() {
    constexpr std::size_t M = 3;
    constexpr std::size_t N = 5;
    constexpr std::size_t k_values[] = {64, 256, 1024, 4096};

    std::mt19937 generator(20260829);
    std::uniform_real_distribution<float> exponent_distribution(-10.0F, 10.0F);
    std::bernoulli_distribution sign_distribution(0.5);

    for (const std::size_t K : k_values) {
        std::vector<float> A(M * K);
        std::vector<float> B(K * N);

        for (float& value : A) {
            const float magnitude = std::pow(
                10.0F,
                exponent_distribution(generator)
            );
            value = sign_distribution(generator) ? magnitude : -magnitude;
        }

        for (float& value : B) {
            const float magnitude = std::pow(
                10.0F,
                exponent_distribution(generator)
            );
            value = sign_distribution(generator) ? magnitude : -magnitude;
        }

        run_case("dynamic_range_random", A, B, M, N, K);
    }
}

void run_special_value_cases() {
    constexpr std::size_t M = 1;
    constexpr std::size_t N = 1;

    {
        const std::vector<float> A = {
            1.0F,
            std::numeric_limits<float>::quiet_NaN(),
            2.0F
        };
        const std::vector<float> B(3, 1.0F);
        run_case("nan_input", A, B, M, N, 3);
    }

    {
        const std::vector<float> A = {
            1.0F,
            std::numeric_limits<float>::infinity(),
            2.0F
        };
        const std::vector<float> B(3, 1.0F);
        run_case("positive_infinity", A, B, M, N, 3);
    }

    {
        const std::vector<float> A = {
            std::numeric_limits<float>::infinity(),
            1.0F
        };
        const std::vector<float> B = {0.0F, 1.0F};
        run_case("infinity_times_zero", A, B, M, N, 2);
    }

    {
        const std::vector<float> A = {
            std::numeric_limits<float>::infinity(),
            -std::numeric_limits<float>::infinity()
        };
        const std::vector<float> B = {1.0F, 1.0F};
        run_case("opposite_infinities", A, B, M, N, 2);
    }

    {
        const std::vector<float> A = {-0.0F};
        const std::vector<float> B = {1.0F};
        run_case("negative_zero", A, B, M, N, 1);
    }

    {
        const float denormal = std::numeric_limits<float>::denorm_min();
        const std::vector<float> A = {denormal, denormal};
        const std::vector<float> B = {1.0F, 1.0F};
        run_case("subnormal", A, B, M, N, 2);
    }
}

}  // namespace

int main() {
    std::cout << std::setprecision(10);
    std::cout
        << "Numerical comparison: strict double-accumulating reference"
        << " vs source-isolated native fast-math transposed kernel\n";

    run_random_k_sweep();
    run_positive_k_sweep();
    run_cancellation_cases();
    run_dynamic_range_cases();
    run_special_value_cases();

    return 0;
}
