#include "matmul.hpp"

#include <iostream>
#include <stdexcept>
#include <cmath>
#include <sstream>

namespace {

void test_one_by_one_overwrite() {
    const float A[] = {2.0F};
    const float B[] = {3.0F};
    float C[] = {999.0F};

    mini_gpu::matmul_reference(
        A,
        B,
        C,
        1,  // M
        1,  // N
        1   // K
    );

    const float expected = 6.0F;

    if (C[0] != expected) {
        throw std::runtime_error(
            "test_one_by_one_overwrite failed"
        );
    }
}

}  // namespace

void test_two_by_three_times_three_by_two() {
    const float A[] = {
        1.0F, 2.0F, 3.0F,
        4.0F, 5.0F, 6.0F
    };

    const float B[] = {
         7.0F,  8.0F,
         9.0F, 10.0F,
        11.0F, 12.0F
    };

    float C[] = {
        999.0F, 999.0F,
        999.0F, 999.0F
    };

    const float expected[] = {
         58.0F,  64.0F,
        139.0F, 154.0F
    };

    mini_gpu::matmul_reference(
        A,
        B,
        C,
        2,  // M
        2,  // N
        3   // K
    );

    for (std::size_t index = 0; index < 4; ++index) {
        if (C[index] != expected[index]) {
            throw std::runtime_error(
                "test_two_by_three_times_three_by_two failed"
            );
        }
    }
}

void test_zero_k_writes_zero_output() {
    float C[] = {
        999.0F, 999.0F, 999.0F,
        999.0F, 999.0F, 999.0F
    };

    mini_gpu::matmul_reference(
        nullptr,
        nullptr,
        C,
        2,  // M
        3,  // N
        0   // K
    );

    for (std::size_t index = 0; index < 6; ++index) {
        if (C[index] != 0.0F) {
            throw std::runtime_error(
                "test_zero_k_writes_zero_output failed"
            );
        }
    }
}

void test_zero_m_allows_null_pointers() {
    mini_gpu::matmul_reference(
        nullptr,
        nullptr,
        nullptr,
        0,  // M
        3,  // N
        5   // K
    );
}

void test_null_c_throws() {
    const float A[] = {2.0F};
    const float B[] = {3.0F};

    bool caught_expected_exception = false;

    try {
        mini_gpu::matmul_reference(
            A,
            B,
            nullptr,
            1,  // M
            1,  // N
            1   // K
        );
    } catch (const std::invalid_argument&) {
        caught_expected_exception = true;
    }

    if (!caught_expected_exception) {
        throw std::runtime_error(
            "test_null_c_throws failed: expected std::invalid_argument"
        );
    }
}

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

    const float absolute_error = std::fabs(actual - expected);
    const float allowed_error =
        atol + rtol * std::fabs(expected);

    return absolute_error <= allowed_error;
}

void expect_array_near(
    const float* actual,
    const float* expected,
    std::size_t count,
    const char* test_name
) {
    for (std::size_t index = 0; index < count; ++index) {
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

void test_decimal_and_negative_values() {
    const float A[] = {
        0.1F, -0.2F,
        1.5F,  0.3F
    };

    const float B[] = {
         0.4F, 2.0F,
        -1.0F, 0.5F
    };

    float C[] = {
        999.0F, 999.0F,
        999.0F, 999.0F
    };

    const float expected[] = {
        0.24F, 0.10F,
        0.30F, 3.15F
    };

    mini_gpu::matmul_reference(
        A,
        B,
        C,
        2,  // M
        2,  // N
        2   // K
    );

    expect_array_near(
        C,
        expected,
        4,
        "test_decimal_and_negative_values"
    );
}

void test_cpu_ijk_matches_reference() {
    const float A[] = {
         0.25F, -1.50F,  2.00F,
         3.00F,  0.50F, -0.75F
    };

    const float B[] = {
         1.00F, -2.00F,
         0.50F,  4.00F,
        -1.00F,  0.25F
    };

    float expected[4] = {};
    float actual[4] = {};

    mini_gpu::matmul_reference(
        A,
        B,
        expected,
        2,  // M
        2,  // N
        3   // K
    );

    mini_gpu::matmul_cpu_ijk(
        A,
        B,
        actual,
        2,  // M
        2,  // N
        3   // K
    );

    expect_array_near(
        actual,
        expected,
        4,
        "test_cpu_ijk_matches_reference"
    );
}

void test_cpu_ikj_matches_reference_and_overwrites() {
    const float A[] = {
         0.25F, -1.50F,  2.00F,
         3.00F,  0.50F, -0.75F
    };

    const float B[] = {
         1.00F, -2.00F,
         0.50F,  4.00F,
        -1.00F,  0.25F
    };

    float expected[4] = {};

    float actual[] = {
        999.0F, 999.0F,
        999.0F, 999.0F
    };

    mini_gpu::matmul_reference(
        A,
        B,
        expected,
        2,  // M
        2,  // N
        3   // K
    );

    mini_gpu::matmul_cpu_ikj(
        A,
        B,
        actual,
        2,  // M
        2,  // N
        3   // K
    );

    expect_array_near(
        actual,
        expected,
        4,
        "test_cpu_ikj_matches_reference_and_overwrites"
    );
}

int main() {
    try {
        test_one_by_one_overwrite();
	test_two_by_three_times_three_by_two();
	test_zero_k_writes_zero_output();
    	test_zero_m_allows_null_pointers();
	test_null_c_throws();
	test_decimal_and_negative_values();
	test_cpu_ijk_matches_reference();
	test_cpu_ikj_matches_reference_and_overwrites();
    } catch (const std::exception& error) {
        std::cerr << "TEST FAILED: " << error.what() << '\n';
        return 1;
    }

    std::cout << "All correctness tests passed.\n";
    return 0;
}
