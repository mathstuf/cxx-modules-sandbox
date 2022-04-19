add_library(simple)
target_sources(simple
    PRIVATE
        use.mpp
    PRIVATE
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            duplicate.mpp
            another.mpp)
