add_library(simple)
generate_export_header(simple)
target_sources(simple
    PRIVATE
        use.cpp
    PUBLIC
        FILE_SET headers TYPE HEADERS
        BASE_DIRS
            "${CMAKE_CURRENT_BINARY_DIR}"
        FILES
            "${CMAKE_CURRENT_BINARY_DIR}/simple_export.h"
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp
            another.mpp)
