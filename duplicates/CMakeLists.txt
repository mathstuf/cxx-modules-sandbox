add_library(duplicates)
target_sources(duplicates
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp)
