set_source_files_properties(
    another.mpp
    duplicate.mpp
    PROPERTIES
        EXPERIMENTAL_CXX_SOURCE_FILE_TYPE "INTERFACE")

add_library(simple
    duplicate.mpp
    another.mpp
    use.mpp)
