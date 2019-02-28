cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(cxxmodules CXX)

set(CMAKE_CXX_STANDARD 20)

include(CTest)

add_subdirectory(simple)
add_subdirectory(duplicates)
add_subdirectory(duplicates-same-dir)
add_subdirectory(link-use)
add_subdirectory(link-use-mask)

# GCC doesn't fully support partitions yet. "provided" partitions
# are not in the "provides" field of the .dd. It also says they
# are required by ":parta" rather than fully qualified.
#add_subdirectory(partitions)
