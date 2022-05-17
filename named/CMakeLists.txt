cmake_minimum_required(VERSION 3.23)
project(cxx-modules-examples CXX)

set(CMAKE_CXX_STANDARD 20)

add_library(with_named_modules)
target_sources(with_named_modules
    PRIVATE
        mymodule_impl.cpp
        mymodule_part_impl.cpp
        main.cpp
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            mymodule_part.cpp
            mymodule.cpp
        FILE_SET cxx_modules_internals TYPE CXX_MODULE_INTERNAL_PARTITIONS FILES
            mymodule_part_internal.cpp)

install(TARGETS with_named_modules
    EXPORT with_named_modules
    RUNTIME
        DESTINATION "bin"
        COMPONENT "runtime"
    ARCHIVE
        DESTINATION "lib"
        COMPONENT "development"
    LIBRARY
        DESTINATION "lib"
        COMPONENT "runtime"
        NAMELINK_COMPONENT "development"
    FILE_SET cxx_modules
        DESTINATION "include/cxx/cxx-modules-examples"
        COMPONENT "development"
    FILE_SET cxx_modules_internals
        DESTINATION "include/cxx/cxx-modules-examples"
        COMPONENT "development"
    CXX_MODULES_BMI
        DESTINATION "lib/${CMAKE_CXX_COMPILER_ID}-${CMAKE_CXX_COMPILER_VERSION}/$<CONFIG>"
        COMPONENT "development")

export(
    EXPORT with_named_modules
    NAMESPACE NS::
    FILE "${CMAKE_BINARY_DIR}/lib/cmake/cxx-modules-examples/with_named_modules-targets.cmake"
    CXX_MODULES_DIRECTORY "with_named_modules-cxx-modules")
install(
    EXPORT with_named_modules
    NAMESPACE NS::
    DESTINATION "lib/cmake/cxx-modules-examples"
    FILE "with_named_modules-targets.cmake"
    CXX_MODULES_DIRECTORY "with_named_modules-cxx-modules"
    COMPONENT "development")
