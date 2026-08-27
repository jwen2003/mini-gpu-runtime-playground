cmake_minimum_required(VERSION 3.20)

project(
    mini_gpu_runtime_playground
    VERSION 0.1.0
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(matmul_cpu
    src/cpu/reference.cpp
    src/cpu/ijk.cpp
    src/cpu/ikj.cpp
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

enable_testing()

add_test(
    NAME matmul_correctness
    COMMAND correctness_test
)
