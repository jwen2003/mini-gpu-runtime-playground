#include "matmul.hpp"

#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstddef>
#include <iostream>
#include <random>
#include <stdexcept>
#include <string>
#include <vector>

namespace {

using MatmulFunction = void (*)(
    const float*,
    const float*,
    float*,
    std::size_t,
    std::size_t,
    std::size_t
);

bool nearly_equal(
    float actual,
    float expected,
    float atol = 1.0e-4F,
    float rtol = 1.0e-3F
) {
    if (std::isnan(actual) || std::isnan(expected)) {
        return false;
    }

    if (std::isinf(actual) || std::isinf(expected)) {
        return actual == expected;
    }

    return std::fabs(actual - expected)
        <= atol + rtol * std::fabs(expected);
}

void verify_result(
    const std::vector<float>& actual,
    const std::vector<float>& expected
) {
    for (std::size_t index = 0; index < actual.size(); ++index) {
        if (!nearly_equal(actual[index], expected[index])) {
            throw std::runtime_error(
                "Benchmark result failed correctness verification"
            );
        }
    }
}

double percentile(
    const std::vector<double>& sorted_values,
    double fraction
) {
    const double position =
        fraction * static_cast<double>(sorted_values.size() - 1);

    const std::size_t lower =
        static_cast<std::size_t>(std::floor(position));

    const std::size_t upper =
        static_cast<std::size_t>(std::ceil(position));

    const double weight =
        position - static_cast<double>(lower);

    return sorted_values[lower] * (1.0 - weight)
         + sorted_values[upper] * weight;
}

void run_benchmark(
    const std::string& name,
    MatmulFunction function,
    const std::vector<float>& A,
    const std::vector<float>& B,
    const std::vector<float>& expected,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    constexpr std::size_t warmup_count = 5;
    constexpr std::size_t repeat_count = 10;

    std::vector<float> C(M * N, 999.0F);

    // Warm-up runs are excluded from measurement.
    for (std::size_t repeat = 0; repeat < warmup_count; ++repeat) {
        function(A.data(), B.data(), C.data(), M, N, K);
    }

    std::vector<double> durations_ms;
    durations_ms.reserve(repeat_count);

    for (std::size_t repeat = 0; repeat < repeat_count; ++repeat) {
        const auto start = std::chrono::steady_clock::now();

        function(A.data(), B.data(), C.data(), M, N, K);

        const auto end = std::chrono::steady_clock::now();

        const double duration_ms =
            std::chrono::duration<double, std::milli>(
                end - start
            ).count();

        durations_ms.push_back(duration_ms);
    }

    // Correctness checking is deliberately outside the timed region.
    verify_result(C, expected);

    // Reading C after measurement makes the output observably used.
    double checksum = 0.0;
    for (const float value : C) {
        checksum += static_cast<double>(value);
    }

    std::sort(durations_ms.begin(), durations_ms.end());

    const double minimum_ms = durations_ms.front();
    const double p10_ms = percentile(durations_ms, 0.10);
    const double median_ms = percentile(durations_ms, 0.50);
    const double p90_ms = percentile(durations_ms, 0.90);
    const double maximum_ms = durations_ms.back();

    const double operation_count =
        2.0
        * static_cast<double>(M)
        * static_cast<double>(N)
        * static_cast<double>(K);

    const double gflops =
        operation_count / (median_ms * 1.0e6);

    std::cout
    << name
    << ": min=" << minimum_ms << " ms"
    << ", p10=" << p10_ms << " ms"
    << ", median=" << median_ms << " ms"
    << ", p90=" << p90_ms << " ms"
    << ", max=" << maximum_ms << " ms"
    << ", GFLOP/s=" << gflops
    << ", checksum=" << checksum
    << '\n';
}

}  // namespace

int main(int argc, char* argv[]) {
    constexpr std::size_t M = 256;
    constexpr std::size_t K = 256;

    if (argc != 3) {
        std::cerr
            << "Usage: " << argv[0]
            << " <ijk|ikj> <N>\n";
        return 1;
    }

    const std::string implementation = argv[1];

    std::size_t N = 0;

    try {
        const std::string n_argument = argv[2];
        std::size_t parsed_characters = 0;

        const unsigned long long parsed_value =
            std::stoull(n_argument, &parsed_characters);

        if (parsed_characters != n_argument.size()) {
            throw std::invalid_argument("trailing characters");
        }

        N = static_cast<std::size_t>(parsed_value);
    } catch (const std::exception&) {
        std::cerr << "Invalid N: " << argv[2] << '\n';
        return 1;
    }

    MatmulFunction function = nullptr;
    std::string benchmark_name;

    if (implementation == "ijk") {
        function = mini_gpu::matmul_cpu_ijk;
        benchmark_name = "cpu_ijk";
    } else if (implementation == "ikj") {
        function = mini_gpu::matmul_cpu_ikj;
        benchmark_name = "cpu_ikj";
    } else {
        std::cerr
            << "Invalid implementation: " << implementation
            << ". Expected ijk or ikj.\n";
        return 1;
    }

    std::mt19937 generator(20260825);
    std::uniform_real_distribution<float> distribution(-1.0F, 1.0F);

    std::vector<float> A(M * K);
    std::vector<float> B(K * N);
    std::vector<float> expected(M * N);

    for (float& value : A) {
        value = distribution(generator);
    }

    for (float& value : B) {
        value = distribution(generator);
    }

    mini_gpu::matmul_reference(
        A.data(),
        B.data(),
        expected.data(),
        M,
        N,
        K
    );

    std::cout
        << "implementation=" << benchmark_name
        << ", M=" << M
        << ", N=" << N
        << ", K=" << K
        << '\n';

    run_benchmark(
        benchmark_name,
        function,
        A,
        B,
        expected,
        M,
        N,
        K
    );

    return 0;
}
