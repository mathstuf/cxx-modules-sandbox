cmake_minimum_required(VERSION 3.26 FATAL_ERROR)
project(cxxmodules CXX)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS NO)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_SCAN_FOR_MODULES YES)

# See #10.
# set(CMAKE_CXX_VISIBILITY_PRESET hidden)

set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API 2182bf5c-ef0d-489a-91da-49dbc3090d2a)
set(CMake_TEST_CXXModules_UUID "a246741c-d067-4019-a8fb-3d16b0c9d1d3")

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set(CMAKE_EXPERIMENTAL_CXX_MODULE_DYNDEP 1)
  set(CMAKE_EXPERIMENTAL_CXX_MODULE_MAP_FORMAT "clang")
  set(CMAKE_EXE_LINKER_FLAGS -lstdc++)
  # Workaround for C++Modules: Missing module map flags in exported compile commands
  # see https://gitlab.kitware.com/cmake/cmake/-/issues/24618
  set(CMAKE_CXX_COMPILE_OBJECT "${CMAKE_CXX_COMPILE_OBJECT} @<OBJECT>.modmap")

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  set(CMAKE_EXPERIMENTAL_CXX_MODULE_DYNDEP 1)

endif()

include(GenerateExportHeader)

# include(CTest)
enable_testing()

add_subdirectory(simple)
add_subdirectory(duplicates)
add_subdirectory(duplicates-same-dir)
add_subdirectory(link-use)
add_subdirectory(link-use-mask)
#TODO(CK): add_subdirectory(good-scanner)
add_subdirectory(generated)

# NOTE: This dit use of CXX_MODULE_INTERNAL_PARTITIONS?
#FIXME: add_subdirectory(partitions)

# The CMake APIs used here are not yet implemented!
# add_subdirectory(header-units)
