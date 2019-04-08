add_library(good-scanner
    # These should trip up `sed`-level scanners.
    header-import.cpp
    import.cpp
    export.cpp)
