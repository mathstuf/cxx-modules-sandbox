add_library(partitions)
target_sources(partitions
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            module.mpp
            parta.mpp
            partb.mpp
            impl.mpp)
