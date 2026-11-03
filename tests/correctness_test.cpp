#include "matmul.hpp"

#include <cmath>
#include <cstddef>
#include <iostream>
#include <random>
#include <sstream>
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

struct MatmulImplementation {
    const char* name;
    MatmulFunction function;
};

constexpr MatmulImplementation regular_implementations[] = {
    {"matmul_reference", mini_gpu::matmul_reference},
    {"matmul_cpu_ijk", mini_gpu::matmul_cpu_ijk},
    {"matmul_cpu_ikj", mini_gpu::matmul_cpu_ikj}
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

void expect_array_near(
    const std::vector<float>& actual,
    const std::vector<float>& expected,
    const std::string& test_name
) {
    if (actual.size() != expected.size()) {
        throw std::runtime_error(test_name + " failed: size mismatch");
    }

    for (std::size_t index = 0; index < actual.size(); ++index) {
        if (!nearly_equal(actual[index], expected[index])) {
            std::ostringstream message;
            message
                << test_name
                << " failed at index " << index
                << ": actual=" << actual[index]
                << ", expected=" << expected[index];
            throw std::runtime_error(message.str());
        }
    }
}

template <typename Operation>
void expect_invalid_argument(
    Operation operation,
    const std::string& test_name
) {
    bool caught = false;

    try {
        operation();
    } catch (const std::invalid_argument&) {
        caught = true;
    }

    if (!caught) {
        throw std::runtime_error(
            test_name + " failed: expected std::invalid_argument"
        );
    }
}

void test_known_matrix_for_all_implementations() {
    const std::vector<float> A = {
        1.0F, 2.0F, 3.0F,
        4.0F, 5.0F, 6.0F
    };
    const std::vector<float> B = {
         7.0F,  8.0F,
         9.0F, 10.0F,
        11.0F, 12.0F
    };
    const std::vector<float> expected = {
         58.0F,  64.0F,
        139.0F, 154.0F
    };

    for (const auto& implementation : regular_implementations) {
        std::vector<float> actual(4, 999.0F);
        implementation.function(
            A.data(), B.data(), actual.data(), 2, 2, 3
        );
        expect_array_near(actual, expected, implementation.name);
    }

    std::vector<float> B_transposed(6);
    mini_gpu::transpose_b(B.data(), B_transposed.data(), 2, 3);

    const std::vector<float> expected_transposed = {
        7.0F, 9.0F, 11.0F,
        8.0F, 10.0F, 12.0F
    };
    expect_array_near(
        B_transposed,
        expected_transposed,
        "transpose_b known matrix"
    );

    std::vector<float> actual(4, 999.0F);
    mini_gpu::matmul_cpu_transposed_b(
        A.data(), B_transposed.data(), actual.data(), 2, 2, 3
    );
    expect_array_near(
        actual,
        expected,
        "matmul_cpu_transposed_b known matrix"
    );
}

void test_all_implementations_on_multiple_shapes() {
    constexpr std::size_t shapes[][3] = {
        {1, 1, 1},
        {2, 3, 4},
        {3, 5, 7},
        {5, 3, 4},
        {7, 1, 9},
        {1, 8, 3}
    };

    std::mt19937 generator(20260825);
    std::uniform_real_distribution<float> distribution(-2.0F, 2.0F);

    for (const auto& shape : shapes) {
        const std::size_t M = shape[0];
        const std::size_t N = shape[1];
        const std::size_t K = shape[2];

        std::vector<float> A(M * K);
        std::vector<float> B(K * N);
        for (float& value : A) {
            value = distribution(generator);
        }
        for (float& value : B) {
            value = distribution(generator);
        }

        std::vector<float> expected(M * N);
        mini_gpu::matmul_reference(
            A.data(), B.data(), expected.data(), M, N, K
        );

        for (const auto& implementation : regular_implementations) {
            std::vector<float> actual(M * N, 999.0F);
            implementation.function(
                A.data(), B.data(), actual.data(), M, N, K
            );
            expect_array_near(
                actual,
                expected,
                std::string(implementation.name) + " multi-shape"
            );
        }

        std::vector<float> B_transposed(N * K);
        mini_gpu::transpose_b(
            B.data(), B_transposed.data(), N, K
        );

        std::vector<float> actual_transposed(M * N, 999.0F);
        mini_gpu::matmul_cpu_transposed_b(
            A.data(),
            B_transposed.data(),
            actual_transposed.data(),
            M,
            N,
            K
        );
        expect_array_near(
            actual_transposed,
            expected,
            "matmul_cpu_transposed_b multi-shape"
        );
    }
}

void test_zero_size_semantics() {
    for (const auto& implementation : regular_implementations) {
        implementation.function(nullptr, nullptr, nullptr, 0, 3, 5);

        std::vector<float> C(6, 999.0F);
        implementation.function(nullptr, nullptr, C.data(), 2, 3, 0);
        expect_array_near(
            C,
            std::vector<float>(6, 0.0F),
            std::string(implementation.name) + " K=0"
        );
    }

    mini_gpu::transpose_b(nullptr, nullptr, 0, 5);
    mini_gpu::transpose_b(nullptr, nullptr, 3, 0);
    mini_gpu::matmul_cpu_transposed_b(
        nullptr, nullptr, nullptr, 0, 3, 5
    );

    std::vector<float> C(6, 999.0F);
    mini_gpu::matmul_cpu_transposed_b(
        nullptr, nullptr, C.data(), 2, 3, 0
    );
    expect_array_near(
        C,
        std::vector<float>(6, 0.0F),
        "matmul_cpu_transposed_b K=0"
    );
}

void test_invalid_pointer_semantics() {
    const float value = 1.0F;
    float output = 0.0F;

    for (const auto& implementation : regular_implementations) {
        const MatmulFunction function = implementation.function;
        expect_invalid_argument(
            [function]() {
                const float local_value = 1.0F;
                function(
                    &local_value, &local_value, nullptr, 1, 1, 1
                );
            },
            std::string(implementation.name) + " null C"
        );
    }

    expect_invalid_argument(
        []() {
            float local_output = 0.0F;
            mini_gpu::transpose_b(nullptr, &local_output, 1, 1);
        },
        "transpose_b null B"
    );

    expect_invalid_argument(
        []() {
            const float local_value = 1.0F;
            mini_gpu::transpose_b(&local_value, nullptr, 1, 1);
        },
        "transpose_b null output"
    );

    expect_invalid_argument(
        []() {
            const float local_value = 1.0F;
            mini_gpu::matmul_cpu_transposed_b(
                &local_value, &local_value, nullptr, 1, 1, 1
            );
        },
        "matmul_cpu_transposed_b null C"
    );

    expect_invalid_argument(
        [&value, &output]() {
            mini_gpu::matmul_cpu_transposed_b(
                nullptr, &value, &output, 1, 1, 1
            );
        },
        "matmul_cpu_transposed_b null A"
    );

    expect_invalid_argument(
        [&value, &output]() {
            mini_gpu::matmul_cpu_transposed_b(
                &value, nullptr, &output, 1, 1, 1
            );
        },
        "matmul_cpu_transposed_b null B_transposed"
    );
}

}  // namespace

int main() {
    try {
        test_known_matrix_for_all_implementations();
        test_all_implementations_on_multiple_shapes();
        test_zero_size_semantics();
        test_invalid_pointer_semantics();
    } catch (const std::exception& error) {
        std::cerr << "TEST FAILED: " << error.what() << '\n';
        return 1;
    }

    std::cout << "All correctness tests passed.\n";
    return 0;
}
