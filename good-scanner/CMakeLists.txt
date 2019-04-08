add_library(good-scanner
    # These should trip up `sed`-level scanners.
    header-import.cpp
    import.cpp
    export.cpp

    # Simple modules for use in other sources.
    mod.cpp
    other.cpp

    # Import multiple modules on the same line.
    multi-line.cpp)
