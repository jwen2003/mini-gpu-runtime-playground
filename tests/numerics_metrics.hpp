#pragma once

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <limits>
#include <vector>

namespace mini_gpu::test {

constexpr float absolute_tolerance = 1.0e-4F;
constexpr float relative_tolerance = 1.0e-3F;

struct ErrorSummary {
    double maximum_absolute_error = 0.0;
    double maximum_relative_error = 0.0;
    std::size_t bitwise_matches = 0;
    std::size_t tolerance_failures = 0;
    std::size_t classification_mismatches = 0;
    std::size_t signed_zero_mismatches = 0;
    std::uint64_t maximum_ulp_distance = 0;
    std::size_t worst_absolute_error_index = 0;
    float worst_actual_value = 0.0F;
    float worst_expected_value = 0.0F;
};

inline std::uint32_t ordered_float_bits(float value) {
    std::uint32_t bits = 0;
    static_assert(sizeof(bits) == sizeof(value));
    std::memcpy(&bits, &value, sizeof(bits));

    if ((bits & 0x80000000U) != 0U) {
        return 0x80000000U - (bits & 0x7fffffffU);
    }

    return 0x80000000U + bits;
}

inline std::uint64_t ulp_distance(float first, float second) {
    const std::uint32_t first_ordered = ordered_float_bits(first);
    const std::uint32_t second_ordered = ordered_float_bits(second);

    return first_ordered >= second_ordered
        ? static_cast<std::uint64_t>(first_ordered - second_ordered)
        : static_cast<std::uint64_t>(second_ordered - first_ordered);
}

inline ErrorSummary compare_outputs(
    const std::vector<float>& actual,
    const std::vector<float>& expected
) {
    ErrorSummary summary;

    for (std::size_t index = 0; index < actual.size(); ++index) {
        const float actual_value = actual[index];
        const float expected_value = expected[index];

        if (std::memcmp(&actual_value, &expected_value, sizeof(float)) == 0) {
            ++summary.bitwise_matches;
        }

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

}  // namespace mini_gpu::test
