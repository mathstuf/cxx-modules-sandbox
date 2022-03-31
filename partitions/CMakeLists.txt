set_source_files_properties(
    module.mpp
    parta.mpp
    PROPERTIES
        EXPERIMENTAL_CXX_SOURCE_FILE_TYPE "INTERFACE")

set_source_files_properties(
    impl.mpp
    partb.mpp
    PROPERTIES
        EXPERIMENTAL_CXX_SOURCE_FILE_TYPE "IMPLEMENTATION")

add_library(partitions
    module.mpp
    parta.mpp
    partb.mpp

    impl.mpp)
