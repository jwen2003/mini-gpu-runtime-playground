#include "register_experiment.hpp"
#include "cancellation_cases.hpp"
#include "numerics_metrics.hpp"

#include <algorithm>
#include <charconv>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <random>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

namespace {

using mini_gpu::RegisterTile;

struct Shape {
    std::size_t m;
    std::size_t n;
    std::size_t k;
};

enum class Kernel { ikj, cache, registers };

struct Variant {
    const char* name;
    Kernel kernel;
    bool fast;
    std::size_t outer;
    const char* micro;
    RegisterTile tile = RegisterTile::r2c8;
};

std::vector<Variant> variants() {
#ifdef MINI_GPU_MICROTILE_SEARCH
    constexpr auto* registers = "strict_register_blocked";
    return {
        {"strict_ikj", Kernel::ikj, false, 0, "none"},
        {"strict_cache_blocked", Kernel::cache, false, 128, "none"},
        {registers, Kernel::registers, false, 128, "2x8", RegisterTile::r2c8},
        {registers, Kernel::registers, false, 128, "4x8", RegisterTile::r4c8},
        {registers, Kernel::registers, false, 128, "3x16", RegisterTile::r3c16},
        {registers, Kernel::registers, false, 128, "4x12", RegisterTile::r4c12},
        {registers, Kernel::registers, false, 128, "6x8", RegisterTile::r6c8},
        {registers, Kernel::registers, false, 128, "4x16", RegisterTile::r4c16},
        {registers, Kernel::registers, false, 128, "8x16", RegisterTile::r8c16},
    };
#else
    std::vector<Variant> result;
    for (const bool fast : {false, true}) {
        result.push_back({fast ? "fast_ikj" : "strict_ikj", Kernel::ikj, fast, 0, "none"});
        for (const std::size_t outer : {128, 64}) {
            result.push_back({
                fast ? "fast_cache_blocked" : "strict_cache_blocked",
                Kernel::cache, fast, outer, "none"
            });
            const auto* name = fast ? "fast_register_blocked" : "strict_register_blocked";
            result.push_back({name, Kernel::registers, fast, outer, "2x8", RegisterTile::r2c8});
            result.push_back({name, Kernel::registers, fast, outer, "4x8", RegisterTile::r4c8});
            result.push_back({name, Kernel::registers, fast, outer, "4x16", RegisterTile::r4c16});
            result.push_back({name, Kernel::registers, fast, outer, "8x16", RegisterTile::r8c16});
        }
    }
    return result;
#endif
}

struct Matrices {
    Shape shape;
    std::vector<float> A;
    std::vector<float> B;
    std::vector<float> C;

    void run(Variant variant) {
        const auto [M, N, K] = shape;
        const auto block = variant.outer;
        switch (variant.kernel) {
        case Kernel::ikj: {
#ifdef MINI_GPU_MICROTILE_SEARCH
            const auto kernel = mini_gpu::matmul_cpu_ikj;
#else
            const auto kernel = variant.fast ? mini_gpu::matmul_cpu_ikj_fast
                                             : mini_gpu::matmul_cpu_ikj;
#endif
            kernel(A.data(), B.data(), C.data(), M, N, K);
            break;
        }
        case Kernel::cache: {
#ifdef MINI_GPU_MICROTILE_SEARCH
            const auto kernel = mini_gpu::matmul_cpu_blocked_ikj;
#else
            const auto kernel = variant.fast ? mini_gpu::matmul_cpu_blocked_ikj_fast
                                             : mini_gpu::matmul_cpu_blocked_ikj;
#endif
            kernel(A.data(), B.data(), C.data(), M, N, K, block, block, block);
            break;
        }
        case Kernel::registers: {
#ifdef MINI_GPU_MICROTILE_SEARCH
            const auto kernel = mini_gpu::matmul_cpu_register_blocked_ikj;
#else
            const auto kernel = variant.fast ? mini_gpu::matmul_cpu_register_blocked_ikj_fast
                                             : mini_gpu::matmul_cpu_register_blocked_ikj;
#endif
            kernel(A.data(), B.data(), C.data(), M, N, K, block, block, block, variant.tile);
            break;
        }
        }
    }

    std::vector<float> reference() const {
        const auto [M, N, K] = shape;
        std::vector<float> expected(C.size());
        mini_gpu::matmul_reference(A.data(), B.data(), expected.data(), M, N, K);
        return expected;
    }
};

std::size_t elements(std::size_t a, std::size_t b) {
    if (a > std::vector<float>().max_size() / b) {
        throw std::invalid_argument("matrix exceeds allocation limits");
    }
    return a * b;
}

Matrices random_matrices(Shape shape, std::mt19937& generator) {
    const auto [M, N, K] = shape;
    Matrices result{shape, std::vector<float>(elements(M, K)),
                    std::vector<float>(elements(K, N)),
                    std::vector<float>(elements(M, N))};
    std::uniform_real_distribution<float> distribution(-1.0F, 1.0F);
    for (float& value : result.A) {
        value = distribution(generator);
    }
    for (float& value : result.B) {
        value = distribution(generator);
    }
    return result;
}

void report_metrics(const mini_gpu::test::ErrorSummary& summary) {
    std::cout << ',' << summary.bitwise_matches << ',' << summary.maximum_absolute_error
              << ',' << summary.maximum_relative_error << ',' << summary.maximum_ulp_distance
              << ',' << summary.tolerance_failures << ',' << summary.classification_mismatches
              << ',' << summary.signed_zero_mismatches;
}

bool verify_case(const std::string& name, Matrices matrices, bool ordinary) {
    const auto [M, N, K] = matrices.shape;
    const auto configurations = variants();
    const auto oracle = matrices.reference();
    matrices.run(configurations.front());
    const auto baseline = matrices.C;
    bool passed = true;
    for (const auto variant : configurations) {
        std::fill(matrices.C.begin(), matrices.C.end(), 999.0F);
        matrices.run(variant);
        const auto strict = mini_gpu::test::compare_outputs(matrices.C, baseline);
        const auto reference = mini_gpu::test::compare_outputs(matrices.C, oracle);
        std::cout << name << ',' << M << ',' << N << ',' << K << ',' << variant.name
                  << ',' << variant.outer << ',' << variant.micro << ',' << matrices.C.size();
        report_metrics(strict);
        report_metrics(reference);
        std::cout << '\n';
        if (!variant.fast) {
            passed &= strict.bitwise_matches == matrices.C.size()
                   && (!ordinary || reference.tolerance_failures == 0)
                   && reference.classification_mismatches == 0;
        }
    }
    return passed;
}

bool numerics() {
    std::cout << "case,m,n,k,version,outer,micro,elements,"
                 "bitwise_ikj,abs_ikj,rel_ikj,ulp_ikj,tol_fail_ikj,class_ikj,zero_ikj,"
                 "bitwise_ref,abs_ref,rel_ref,ulp_ref,tol_fail_ref,class_ref,zero_ref\n";
    std::mt19937 generator(20261110);
    bool passed = true;
#ifdef MINI_GPU_MICROTILE_SEARCH
    constexpr std::size_t sizes[] = {
        1, 7, 8, 9, 11, 12, 13, 15, 16, 17, 31, 32, 33, 127, 128, 129, 255, 256, 257
    };
    constexpr Shape rectangles[] = {{127, 257, 63}, {129, 255, 257}, {255, 257, 129}};
#else
    constexpr std::size_t sizes[] = {1, 31, 32, 33, 127, 128, 129, 255, 256, 257};
    constexpr Shape rectangles[] = {{127, 257, 63}, {129, 255, 257}};
#endif
    for (const auto n : sizes) {
        passed &= verify_case("random", random_matrices({n, n, n}, generator), true);
    }
    for (const auto shape : rectangles) {
        passed &= verify_case("random_rectangular", random_matrices(shape, generator), true);
    }
    mini_gpu::test::run_cancellation_cases(
        [&](const std::string& name, const std::vector<float>& A,
            const std::vector<float>& B, std::size_t M, std::size_t N, std::size_t K) {
            // Run the original input and replicate it across a full microtile.
            // The latter exercises the SIMD loop, not just the scalar edge.
            passed &= verify_case(name, {{M, N, K}, A, B, std::vector<float>(M * N)}, false);
            constexpr std::size_t rows = 8;
            constexpr std::size_t columns = 16;
            std::vector<float> tiled_A(rows * K);
            std::vector<float> tiled_B(K * columns);
            for (std::size_t row = 0; row < rows; ++row) {
                std::copy_n(A.begin(), K, tiled_A.begin() + row * K);
            }
            for (std::size_t k = 0; k < K; ++k) {
                std::fill_n(tiled_B.begin() + k * columns, columns, B[k * N]);
            }
            passed &= verify_case(name + "_full_tile",
                {{rows, columns, K}, tiled_A, tiled_B, std::vector<float>(rows * columns)},
                false);
        }
    );
    return passed;
}

std::size_t positive_size(std::string_view value) {
    std::size_t result = 0;
    const auto end = value.data() + value.size();
    const auto parsed = std::from_chars(value.data(), end, result);
    if (parsed.ec != std::errc{} || parsed.ptr != end || result == 0) {
        throw std::invalid_argument("expected a positive integer");
    }
    return result;
}

void sweep(Shape shape, std::size_t seed) {
    const auto [m, n, k] = shape;
    std::mt19937 generator(20260825);
    auto matrices = random_matrices(shape, generator);
    const auto expected = matrices.reference();
    auto configurations = variants();
#ifdef MINI_GPU_MICROTILE_SEARCH
    const bool high_pressure_control = m == 1024 && n == 1024 && k == 1024;
    configurations.erase(std::remove_if(configurations.begin(), configurations.end(),
        [high_pressure_control](Variant variant) {
            const std::string_view tile = variant.micro;
            return tile == "2x8" || (tile == "8x16" && !high_pressure_control);
        }), configurations.end());
    matrices.run(configurations.front());
    const auto strict = matrices.C;
#endif
    for (const auto variant : configurations) {
        for (int i = 0; i < 3; ++i) {
            matrices.run(variant);
        }
        const auto metrics = mini_gpu::test::compare_outputs(matrices.C, expected);
#ifdef MINI_GPU_MICROTILE_SEARCH
        if (mini_gpu::test::compare_outputs(matrices.C, strict).bitwise_matches != strict.size()) {
            throw std::runtime_error("sweep output differed from strict ikj");
        }
#endif
        if (!variant.fast && (metrics.tolerance_failures || metrics.classification_mismatches)) {
            throw std::runtime_error("strict sweep output failed reference verification");
        }
    }

    const auto calls = static_cast<std::size_t>(std::clamp(
        32.0e6 / (2.0 * m * n * k), 1.0, 256.0
    ));
    std::mt19937 order(seed);
#ifdef MINI_GPU_MICROTILE_SEARCH
    std::cout << "m,n,k,version,outer,micro,round,calls,elapsed_ns,ns_per_call\n";
#else
    std::cout << "n,version,outer,micro,round,calls,elapsed_ns,ns_per_call\n";
#endif
    for (int round = 1; round <= 9; ++round) {
        std::shuffle(configurations.begin(), configurations.end(), order);
        for (const auto variant : configurations) {
            const auto start = std::chrono::steady_clock::now();
            for (std::size_t call = 0; call < calls; ++call) {
                matrices.run(variant);
            }
            const auto duration = std::chrono::steady_clock::now() - start;
            const double ns = std::chrono::duration<double, std::nano>(duration).count();
#ifdef MINI_GPU_MICROTILE_SEARCH
            std::cout << m << ',' << n << ',' << k << ',';
#else
            std::cout << n << ',';
#endif
            std::cout << variant.name << ',' << variant.outer << ','
                      << variant.micro << ',' << round << ',' << calls << ','
                      << ns << ',' << ns / calls << '\n';
        }
    }
}

void counter(std::size_t n, std::size_t calls, std::string_view name,
             std::string_view outer, std::string_view micro) {
    for (const auto variant : variants()) {
        if (name == variant.name && outer == std::to_string(variant.outer)
            && micro == variant.micro) {
            std::mt19937 generator(20260825);
            auto matrices = random_matrices({n, n, n}, generator);
            for (std::size_t i = 0; i < calls; ++i) {
                matrices.run(variant);
            }
            double sum = 0.0;
            for (const float value : matrices.C) {
                sum += value;
            }
            std::cout << "calls=" << calls << ", checksum=" << sum << '\n';
            return;
        }
    }
    throw std::invalid_argument("unknown counter variant");
}

}  // namespace

int main(int argc, char* argv[]) {
    std::cout << std::setprecision(12);
    const std::string_view mode = argc > 1 ? argv[1] : "";
    try {
        if (argc == 2 && mode == "numerics") {
            return numerics() ? 0 : 1;
        }
#ifdef MINI_GPU_MICROTILE_SEARCH
        if (argc == 6 && mode == "sweep") {
            sweep({positive_size(argv[2]), positive_size(argv[3]), positive_size(argv[4])},
                  positive_size(argv[5]));
            return 0;
        }
#else
        if (argc == 4 && mode == "sweep") {
            const auto n = positive_size(argv[2]);
            sweep({n, n, n}, positive_size(argv[3]));
            return 0;
        }
#endif
        if (argc == 7 && mode == "counter") {
            counter(positive_size(argv[2]), positive_size(argv[3]), argv[4], argv[5], argv[6]);
            return 0;
        }
    } catch (const std::exception& error) {
        std::cerr << error.what() << '\n';
        return 1;
    }
#ifdef MINI_GPU_MICROTILE_SEARCH
    std::cerr << "Usage: microtile_search numerics | sweep M N K seed | counter N calls version outer micro\n";
#else
    std::cerr << "Usage: register_experiment numerics | sweep N seed | counter N calls version outer micro\n";
#endif
    return 1;
}
