add_library(good-scanner)
target_sources(good-scanner
    PRIVATE
        # These should trip up `sed`-level scanners.
        header-import.mpp
        macro-messiness.mpp
        import.mpp
        export.mpp
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            # Simple modules for use in other sources.
            mod.mpp
            other.mpp)

add_executable(define-mod
    define.mpp)
target_compile_definitions(define-mod
    PRIVATE
        DEFINE=mod
        USE_MOD)
target_link_libraries(define-mod
    PRIVATE
        good-scanner)
add_test(NAME define-mod COMMAND define-mod)

add_executable(define-other
    define.mpp)
target_compile_definitions(define-other
    PRIVATE
        DEFINE=other)
target_link_libraries(define-other
    PRIVATE
        good-scanner)
add_test(NAME define-other COMMAND define-other)
set_tests_properties(define-other
    PROPERTIES
        WILL_FAIL TRUE)

add_library(export-define-x)
target_sources(export-define-x
    PRIVATE
        import-define.mpp
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            export-define.mpp)
target_compile_definitions(export-define-x
    PRIVATE
        DEFINE=x)

add_library(export-define-y)
target_sources(export-define-y
    PRIVATE
        import-define.mpp
    PUBLIC
        FILE_SET cxx_modules TYPE CXX_MODULES FILES
            export-define.mpp)
target_compile_definitions(export-define-y
    PRIVATE
        DEFINE=y)
