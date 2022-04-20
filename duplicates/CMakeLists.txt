add_library(duplicates)
generate_export_header(duplicates)
target_sources(duplicates
    PUBLIC
        FILE_SET headers TYPE HEADERS
        BASE_DIRS
            "${CMAKE_CURRENT_BINARY_DIR}"
        FILES
            "${CMAKE_CURRENT_BINARY_DIR}/duplicates_export.h"
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp)
