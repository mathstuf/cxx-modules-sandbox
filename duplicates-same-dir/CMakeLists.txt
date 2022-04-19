add_library(duplicates-same-dir-1)
target_sources(duplicates-same-dir-1
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp)
add_library(duplicates-same-dir-2)
target_sources(duplicates-same-dir-2
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp)
