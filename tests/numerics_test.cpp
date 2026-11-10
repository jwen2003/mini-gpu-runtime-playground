#include "cancellation_cases.hpp"
#include "matmul.hpp"
#include "numerics_metrics.hpp"

#include <cstddef>
#include <iomanip>
#include <iostream>
#include <limits>
#include <random>
#include <string>
#include <vector>

namespace {

using mini_gpu::test::compare_outputs;
using mini_gpu::test::ErrorSummary;

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
    mini_gpu::test::run_cancellation_cases(run_case);
    run_dynamic_range_cases();
    run_special_value_cases();

    return 0;
}
