cmake_minimum_required(VERSION 3.20)

project(
    mini_gpu_runtime_playground
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(
    MINI_GPU_BUILD_FAST_MATH_EXPERIMENT
    "Build the native fast-math kernel and numerical comparison tool"
    OFF
)

add_library(matmul_cpu
    src/cpu/reference.cpp
    src/cpu/ijk.cpp
    src/cpu/ikj.cpp
    src/cpu/transposed_b.cpp
)

target_include_directories(matmul_cpu
    PUBLIC
        ${PROJECT_SOURCE_DIR}/include
)

target_compile_options(matmul_cpu
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

add_executable(correctness_test
    tests/correctness_test.cpp
)

target_link_libraries(correctness_test
    PRIVATE
        matmul_cpu
)

target_compile_options(correctness_test
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

add_executable(cpu_benchmark
    benchmarks/cpu_benchmark.cpp
)

target_link_libraries(cpu_benchmark
    PRIVATE
        matmul_cpu
)

target_compile_options(cpu_benchmark
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

if(MINI_GPU_BUILD_FAST_MATH_EXPERIMENT)
    if(NOT CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        message(FATAL_ERROR
            "The fast-math experiment currently requires GCC or Clang"
        )
    endif()

    add_library(matmul_fast_math STATIC
        src/cpu/transposed_b_fast.cpp
    )

    target_include_directories(matmul_fast_math
        PUBLIC
            ${PROJECT_SOURCE_DIR}/include
    )

    target_compile_options(matmul_fast_math
        PRIVATE
            -Wall
            -Wextra
            -Wpedantic
            -O3
            -march=native
            -ffast-math
    )

    add_executable(numerics_test
        tests/numerics_test.cpp
    )

    target_link_libraries(numerics_test
        PRIVATE
            matmul_cpu
            matmul_fast_math
    )

    target_compile_options(numerics_test
        PRIVATE
            -Wall
            -Wextra
            -Wpedantic
    )
endif()

enable_testing()

add_test(
    NAME matmul_correctness
    COMMAND correctness_test
)
