cmake_minimum_required(VERSION 3.10)
project(fit4012_lab4_des LANGUAGES CXX)

# Cấu hình chuẩn C++17 theo yêu cầu bài lab
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(des des.cpp)

target_compile_options(des PRIVATE -Wall -Wextra -pedantic)


# target_include_directories(des PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
