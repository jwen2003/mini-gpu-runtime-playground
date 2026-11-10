#include "matmul.hpp"
#include "numerics_metrics.hpp"

#include <algorithm>
#include <iomanip>
#include <iostream>
#include <random>
#include <stdexcept>
#include <vector>

namespace {

struct Extents {
    std::size_t m;
    std::size_t n;
    std::size_t k;
};

bool compare_case(
    const char* name,
    Extents shape,
    const std::vector<float>& A,
    const std::vector<float>& B,
    bool cancellation = false
) {
    const auto [M, N, K] = shape;
    const std::size_t count = M * N;
    std::vector<float> reference(count);
    std::vector<float> baseline(count);
    std::vector<float> blocked(count);
    mini_gpu::matmul_reference(A.data(), B.data(), reference.data(), M, N, K);
    mini_gpu::matmul_cpu_ikj(A.data(), B.data(), baseline.data(), M, N, K);

    constexpr Extents blocks[] = {
        {8, 8, 8}, {16, 16, 16}, {32, 32, 32}, {64, 64, 64}, {128, 128, 128},
        {7, 16, 3}, {3, 5, 2}
    };
    // This cancellation probe deliberately separates FP32 accumulation from
    // the double oracle. Verify both known answers before comparing tilings.
    bool passed = !cancellation || (baseline[0] == 2.0F && reference[0] == 4.0F);
    for (const auto [BM, BN, BK] : blocks) {
        std::fill(blocked.begin(), blocked.end(), 999.0F);
        mini_gpu::matmul_cpu_blocked_ikj(
            A.data(), B.data(), blocked.data(), M, N, K, BM, BN, BK
        );
        const auto strict = mini_gpu::test::compare_outputs(blocked, baseline);
        const auto oracle = mini_gpu::test::compare_outputs(blocked, reference);
        std::cout << name << ',' << M << ',' << N << ',' << K << ','
                  << BM << ',' << BN << ',' << BK << ',' << count << ','
                  << strict.bitwise_matches << ',' << oracle.bitwise_matches << ','
                  << oracle.maximum_absolute_error << ','
                  << oracle.maximum_relative_error << ','
                  << oracle.maximum_ulp_distance << ',' << oracle.tolerance_failures
                  << ',' << oracle.classification_mismatches << ','
                  << oracle.signed_zero_mismatches << '\n';
        passed &= strict.bitwise_matches == count
               && oracle.tolerance_failures == (cancellation ? 1U : 0U)
               && oracle.classification_mismatches == 0;
    }
    return passed;
}

bool check_edge_contract() {
    mini_gpu::matmul_cpu_blocked_ikj(nullptr, nullptr, nullptr, 0, 3, 5, 2, 4, 8);
    mini_gpu::matmul_cpu_blocked_ikj(nullptr, nullptr, nullptr, 3, 0, 5, 2, 4, 8);
    std::vector<float> output(6, 999.0F);
    mini_gpu::matmul_cpu_blocked_ikj(
        nullptr, nullptr, output.data(), 2, 3, 0, 2, 4, 8
    );
    if (output != std::vector<float>(6, 0.0F)) {
        return false;
    }
    try {
        mini_gpu::matmul_cpu_blocked_ikj(
            nullptr, nullptr, output.data(), 2, 3, 0, 2, 0, 8
        );
    } catch (const std::invalid_argument&) {
        return true;
    }
    return false;
}

}  // namespace

int main() {
    std::cout << std::setprecision(10)
              << "case,m,n,k,bm,bn,bk,elements,bitwise_ikj,bitwise_reference,"
                 "max_abs_reference,max_rel_reference,max_ulp_reference,"
                 "tolerance_failures,classification_mismatches,signed_zero_mismatches\n";
    constexpr Extents shapes[] = {
        {1, 1, 1}, {31, 31, 31}, {32, 32, 32}, {33, 33, 33},
        {255, 255, 255}, {256, 256, 256}, {257, 257, 257},
        {31, 32, 33}, {127, 257, 63}, {33, 17, 65}
    };
    std::mt19937 generator(20261110);
    std::uniform_real_distribution<float> distribution(-1.0F, 1.0F);
    bool passed = check_edge_contract();
    for (const auto [M, N, K] : shapes) {
        std::vector<float> A(M * K);
        std::vector<float> B(K * N);
        for (float& value : A) {
            value = distribution(generator);
        }
        for (float& value : B) {
            value = distribution(generator);
        }
        passed &= compare_case("random", {M, N, K}, A, B);
    }

    // Reordering K panels can change how many small contributions survive.
    // Strict FP32 loses the first two ones; the double oracle retains all four.
    passed &= compare_case(
        "cancellation", {1, 1, 8},
        {1.0e10F, -1.0e10F, 1.0F, 1.0F, 1.0e10F, -1.0e10F, 1.0F, 1.0F},
        std::vector<float>(8, 1.0F), true
    );
    return passed ? 0 : 1;
}
