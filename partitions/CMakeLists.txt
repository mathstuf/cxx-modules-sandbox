add_library(partitions)
target_sources(partitions
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            module.mpp
            parta.mpp
        FILE_SET cxx_module_internal_partitions TYPE CXX_MODULE_INTERNAL_PARTITIONS FILES
            partb.mpp
            impl.mpp)
