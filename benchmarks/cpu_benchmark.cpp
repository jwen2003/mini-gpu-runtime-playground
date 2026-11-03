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

struct TimingStatistics {
    double minimum_ms;
    double p10_ms;
    double median_ms;
    double p90_ms;
    double maximum_ms;
};

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
    const std::vector<float>& expected,
    const std::string& name
) {
    if (actual.size() != expected.size()) {
        throw std::runtime_error(
            name + ": result size does not match expected size"
        );
    }

    for (std::size_t index = 0; index < actual.size(); ++index) {
        if (!nearly_equal(actual[index], expected[index])) {
            throw std::runtime_error(
                name + ": correctness verification failed at index "
                + std::to_string(index)
            );
        }
    }
}

void verify_transpose(
    const std::vector<float>& B,
    const std::vector<float>& B_transposed,
    std::size_t N,
    std::size_t K
) {
    for (std::size_t k = 0; k < K; ++k) {
        for (std::size_t j = 0; j < N; ++j) {
            const float expected = B[k * N + j];
            const float actual = B_transposed[j * K + k];

            if (actual != expected) {
                throw std::runtime_error(
                    "transpose-only: correctness verification failed"
                );
            }
        }
    }
}

double checksum(const std::vector<float>& values) {
    double sum = 0.0;
    for (const float value : values) {
        sum += static_cast<double>(value);
    }
    return sum;
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
    const double weight = position - static_cast<double>(lower);

    return sorted_values[lower] * (1.0 - weight)
         + sorted_values[upper] * weight;
}

template <typename Operation>
TimingStatistics measure_operation(Operation operation) {
    constexpr std::size_t warmup_count = 5;
    constexpr std::size_t repeat_count = 10;

    for (std::size_t repeat = 0; repeat < warmup_count; ++repeat) {
        operation();
    }

    std::vector<double> durations_ms;
    durations_ms.reserve(repeat_count);

    for (std::size_t repeat = 0; repeat < repeat_count; ++repeat) {
        const auto start = std::chrono::steady_clock::now();
        operation();
        const auto end = std::chrono::steady_clock::now();

        durations_ms.push_back(
            std::chrono::duration<double, std::milli>(end - start).count()
        );
    }

    std::sort(durations_ms.begin(), durations_ms.end());

    return {
        durations_ms.front(),
        percentile(durations_ms, 0.10),
        percentile(durations_ms, 0.50),
        percentile(durations_ms, 0.90),
        durations_ms.back()
    };
}

void print_timing(const TimingStatistics& timing) {
    std::cout
        << "min=" << timing.minimum_ms << " ms"
        << ", p10=" << timing.p10_ms << " ms"
        << ", median=" << timing.median_ms << " ms"
        << ", p90=" << timing.p90_ms << " ms"
        << ", max=" << timing.maximum_ms << " ms";
}

double matmul_operation_count(
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    return 2.0
        * static_cast<double>(M)
        * static_cast<double>(N)
        * static_cast<double>(K);
}

void run_regular_matmul(
    const std::string& name,
    MatmulFunction function,
    const std::vector<float>& A,
    const std::vector<float>& B,
    const std::vector<float>& expected,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    std::vector<float> C(M * N, 999.0F);

    const TimingStatistics timing = measure_operation([&]() {
        function(A.data(), B.data(), C.data(), M, N, K);
    });

    verify_result(C, expected, name);

    const double gflops =
        matmul_operation_count(M, N, K) / (timing.median_ms * 1.0e6);

    std::cout << name << ": ";
    print_timing(timing);
    std::cout
        << ", GFLOP/s=" << gflops
        << ", checksum=" << checksum(C)
        << '\n';
}

void run_transposed_kernel(
    const std::vector<float>& A,
    const std::vector<float>& B,
    const std::vector<float>& expected,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    std::vector<float> B_transposed(N * K);
    std::vector<float> C(M * N, 999.0F);

    // Preprocessing is deliberately outside the timed region.
    mini_gpu::transpose_b(
        B.data(), B_transposed.data(), N, K
    );

    const TimingStatistics timing = measure_operation([&]() {
        mini_gpu::matmul_cpu_transposed_b(
            A.data(), B_transposed.data(), C.data(), M, N, K
        );
    });

    verify_result(C, expected, "transposed-kernel");

    const double gflops =
        matmul_operation_count(M, N, K) / (timing.median_ms * 1.0e6);

    std::cout << "transposed-kernel: ";
    print_timing(timing);
    std::cout
        << ", GFLOP/s=" << gflops
        << ", checksum=" << checksum(C)
        << '\n';
}

void run_transpose_only(
    const std::vector<float>& B,
    std::size_t N,
    std::size_t K
) {
    std::vector<float> B_transposed(N * K);

    const TimingStatistics timing = measure_operation([&]() {
        mini_gpu::transpose_b(
            B.data(), B_transposed.data(), N, K
        );
    });

    verify_transpose(B, B_transposed, N, K);

    // Logical traffic: one read from B and one write to B_transposed.
    const double logical_bytes =
        2.0
        * static_cast<double>(N)
        * static_cast<double>(K)
        * static_cast<double>(sizeof(float));
    const double logical_gb_per_second =
        logical_bytes / (timing.median_ms * 1.0e6);

    std::cout << "transpose-only: ";
    print_timing(timing);
    std::cout
        << ", logical_GB/s=" << logical_gb_per_second
        << ", checksum=" << checksum(B_transposed)
        << '\n';
}

void run_transposed_end_to_end(
    const std::vector<float>& A,
    const std::vector<float>& B,
    const std::vector<float>& expected,
    std::size_t M,
    std::size_t N,
    std::size_t K
) {
    std::vector<float> B_transposed(N * K);
    std::vector<float> C(M * N, 999.0F);

    // Allocation remains outside the timed region. Each measured iteration
    // includes both B-to-B_transposed conversion and matrix multiplication.
    const TimingStatistics timing = measure_operation([&]() {
        mini_gpu::transpose_b(
            B.data(), B_transposed.data(), N, K
        );
        mini_gpu::matmul_cpu_transposed_b(
            A.data(), B_transposed.data(), C.data(), M, N, K
        );
    });

    verify_transpose(B, B_transposed, N, K);
    verify_result(C, expected, "transposed-e2e");

    // Only Matmul FLOPs are counted; transpose time remains in the denominator.
    const double effective_gflops =
        matmul_operation_count(M, N, K) / (timing.median_ms * 1.0e6);

    std::cout << "transposed-e2e: ";
    print_timing(timing);
    std::cout
        << ", effective_GFLOP/s=" << effective_gflops
        << ", checksum=" << checksum(C)
        << '\n';
}

std::size_t parse_n(const char* argument) {
    try {
        const std::string text = argument;
        std::size_t parsed_characters = 0;
        const unsigned long long parsed_value =
            std::stoull(text, &parsed_characters);

        if (parsed_characters != text.size()) {
            throw std::invalid_argument("trailing characters");
        }

        return static_cast<std::size_t>(parsed_value);
    } catch (const std::exception&) {
        throw std::invalid_argument(
            std::string("Invalid N: ") + argument
        );
    }
}

std::size_t parse_positive_count(const char* argument) {
    try {
        const std::string text = argument;
        std::size_t parsed_characters = 0;
        const unsigned long long parsed_value =
            std::stoull(text, &parsed_characters);

        if (parsed_characters != text.size() || parsed_value == 0) {
            throw std::invalid_argument("invalid count");
        }

        return static_cast<std::size_t>(parsed_value);
    } catch (const std::exception&) {
        throw std::invalid_argument(
            std::string("Invalid counter iteration count: ") + argument
        );
    }
}

void run_counter_mode(
    const std::string& implementation,
    const std::vector<float>& A,
    const std::vector<float>& B,
    std::size_t M,
    std::size_t N,
    std::size_t K,
    std::size_t iteration_count
) {
    std::vector<float> C(M * N, 999.0F);
    std::vector<float> B_transposed;

    if (
        implementation == "transposed-kernel"
        || implementation == "transpose-only"
        || implementation == "transposed-e2e"
    ) {
        B_transposed.resize(N * K);
    }

    // Kernel-only mode prepares B_transposed before the repeated region.
    if (implementation == "transposed-kernel") {
        mini_gpu::transpose_b(
            B.data(), B_transposed.data(), N, K
        );
    }

    for (std::size_t repeat = 0; repeat < iteration_count; ++repeat) {
        if (implementation == "ijk") {
            mini_gpu::matmul_cpu_ijk(
                A.data(), B.data(), C.data(), M, N, K
            );
        } else if (implementation == "ikj") {
            mini_gpu::matmul_cpu_ikj(
                A.data(), B.data(), C.data(), M, N, K
            );
        } else if (implementation == "transposed-kernel") {
            mini_gpu::matmul_cpu_transposed_b(
                A.data(), B_transposed.data(), C.data(), M, N, K
            );
        } else if (implementation == "transpose-only") {
            mini_gpu::transpose_b(
                B.data(), B_transposed.data(), N, K
            );
        } else {
            mini_gpu::transpose_b(
                B.data(), B_transposed.data(), N, K
            );
            mini_gpu::matmul_cpu_transposed_b(
                A.data(), B_transposed.data(), C.data(), M, N, K
            );
        }
    }

    const double output_checksum =
        implementation == "transpose-only"
        ? checksum(B_transposed)
        : checksum(C);

    std::cout
        << "counter_iterations=" << iteration_count
        << ", checksum=" << output_checksum
        << '\n';
}

void print_usage(const char* program) {
    std::cerr
        << "Usage:\n"
        << "  " << program << " <implementation> <N>\n"
        << "  " << program
        << " <implementation> <N> --counter <iterations>\n"
        << "Implementations:\n"
        << "  ijk\n"
        << "  ikj\n"
        << "  transposed-kernel\n"
        << "  transpose-only\n"
        << "  transposed-e2e\n";
}

}  // namespace

int main(int argc, char* argv[]) {
    constexpr std::size_t M = 256;
    constexpr std::size_t K = 256;

    if (argc != 3 && argc != 5) {
        print_usage(argv[0]);
        return 1;
    }

    const std::string implementation = argv[1];

    std::size_t N = 0;
    try {
        N = parse_n(argv[2]);
    } catch (const std::invalid_argument& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }

    if (
        implementation != "ijk"
        && implementation != "ikj"
        && implementation != "transposed-kernel"
        && implementation != "transpose-only"
        && implementation != "transposed-e2e"
    ) {
        std::cerr << "Invalid implementation: " << implementation << '\n';
        print_usage(argv[0]);
        return 1;
    }

    bool counter_mode = false;
    std::size_t counter_iterations = 0;

    if (argc == 5) {
        if (std::string(argv[3]) != "--counter") {
            std::cerr << "Expected --counter as the third argument.\n";
            print_usage(argv[0]);
            return 1;
        }

        try {
            counter_iterations = parse_positive_count(argv[4]);
            counter_mode = true;
        } catch (const std::invalid_argument& error) {
            std::cerr << error.what() << '\n';
            return 1;
        }
    }

    std::mt19937 generator(20260825);
    std::uniform_real_distribution<float> distribution(-1.0F, 1.0F);

    std::vector<float> A(M * K);
    std::vector<float> B(K * N);
    for (float& value : A) {
        value = distribution(generator);
    }
    for (float& value : B) {
        value = distribution(generator);
    }

    if (counter_mode) {
        std::cout
            << "implementation=" << implementation
            << ", M=" << M
            << ", N=" << N
            << ", K=" << K
            << ", mode=counter"
            << '\n';

        run_counter_mode(
            implementation,
            A,
            B,
            M,
            N,
            K,
            counter_iterations
        );
        return 0;
    }

    std::vector<float> expected;
    if (implementation != "transpose-only") {
        expected.resize(M * N);
        mini_gpu::matmul_reference(
            A.data(), B.data(), expected.data(), M, N, K
        );
    }

    std::cout
        << "implementation=" << implementation
        << ", M=" << M
        << ", N=" << N
        << ", K=" << K
        << '\n';

    if (implementation == "ijk") {
        run_regular_matmul(
            "cpu_ijk", mini_gpu::matmul_cpu_ijk,
            A, B, expected, M, N, K
        );
    } else if (implementation == "ikj") {
        run_regular_matmul(
            "cpu_ikj", mini_gpu::matmul_cpu_ikj,
            A, B, expected, M, N, K
        );
    } else if (implementation == "transposed-kernel") {
        run_transposed_kernel(A, B, expected, M, N, K);
    } else if (implementation == "transpose-only") {
        run_transpose_only(B, N, K);
    } else {
        run_transposed_end_to_end(A, B, expected, M, N, K);
    }

    return 0;
}
