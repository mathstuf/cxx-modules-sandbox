set_source_files_properties(
    duplicate.mpp
    PROPERTIES
        EXPERIMENTAL_CXX_SOURCE_FILE_TYPE "INTERFACE")

add_library(duplicates
    duplicate.mpp)
