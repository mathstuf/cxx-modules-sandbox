include(GNUInstallDirs)

# The scanning of this step will add dynamic dependencies to the modules
# declared in the referenced targets. Without this, the above modules would
# *not* have BMIs created there are no references to them.
add_library(has-header-units SHARED
    module.mpp)
target_include_directories(has-header-units
    PUBLIC
        # Make the header available during the build.
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
        # Install the header for external consumers.
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}")
target_cxx_modules(has-header-units
    INTERFACE
        # Within the build `import "module.h";` is allowed.
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/module.h=\"module.h\">"
        # Once installed, `import <module.h>;` is required. Note that this is
        # (likely) a relative path, so CMake will have to prefix this with
        # `${CMAKE_INSTALL_PREFIX}` if so.
        "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/module.h=<module.h>")

# Install the target.
install(
    TARGETS     has-header-units
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")

# Install the header.
install(
    FILES       module.h
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
