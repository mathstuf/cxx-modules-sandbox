set_source_files_properties(
    duplicate.mpp
    PROPERTIES
        EXPERIMENTAL_CXX_SOURCE_FILE_TYPE "INTERFACE")

add_library(duplicates-same-dir-1
    duplicate.mpp)
add_library(duplicates-same-dir-2
    duplicate.mpp)
