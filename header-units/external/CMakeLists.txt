# Add an interface library which declares an importable header.
add_library(exthdrs INTERFACE)
target_cxx_modules(exthdrs
    INTERFACE
        # The `extlib/header.hpp` header is importable via `import
        # <extlib/header.hpp>;` or `import "extlib/header.hpp";`
        "/usr/include/extlib/header.hpp=<extlib/header.hpp>,\"extlib/header.hpp\"")
# XXX: This is currently not supported by CMake since `INTERFACE` libraries may
# only have `INTERFACE` properties. However, with modules, CMake may need to
# add rules to imported and/or interface targets, so non-`INTERFACE` properties
# now have a use case.
target_compile_definitions(exthdrs
    PRIVATE
        # Compiling these header units should use this preprocessor definition.
        EXTLIB_AS_MODULE)

# Add an interface library which has modules associated with it.
add_library(extmods IMPORTED INTERFACE)
target_cxx_modules(extmods
    INTERFACE
        # The `extmod` module is importable. It is created from the module
        # interface unit `extmod.miu`.
        "/usr/lib/cxx-modules/extmod/extmod.miu=extmod"
        # This module is available, but not used, so a BMI should not be
        # created.
        "/usr/lib/cxx-modules/extmod/notused.miu=notused")

# The scanning of this step will add dynamic dependencies to the modules
# declared in the referenced targets. Without this, the above modules would
# *not* have BMIs created there are no references to them.
add_library(use-ext-mods SHARED
    module.mpp)
target_link_libraries(use-ext-mods
    PRIVATE
        exthdrs
        extmods)
