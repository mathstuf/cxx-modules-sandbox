cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(cxxmodules CXX)

set(CMAKE_CXX_STANDARD 20)

add_library(modules
    module.cpp
    import.cpp
    use.cpp)
