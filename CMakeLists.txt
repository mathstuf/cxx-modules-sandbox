cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(cxxmodules CXX)

set(CMAKE_CXX_STANDARD 20)

include(CTest)

add_subdirectory(simple)
add_subdirectory(duplicates)
add_subdirectory(duplicates-same-dir)
add_subdirectory(link-use)
add_subdirectory(link-use-mask)
add_subdirectory(msvc-naming)
add_subdirectory(good-scanner)
add_subdirectory(generated)

add_subdirectory(partitions)

# The CMake APIs used here are not yet implemented.
#add_subdirectory(header-units)
