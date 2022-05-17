#!/usr/bin/env bash

set -e
set -x

"${BASH_SOURCE%/*}/clean.bash"

# https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Modules.html
# A project-specific mapper is expected to be provided by the build system that invokes the compiler.
# The default mapper generates CMI files in a `gcm.cache` directory. CMI files have a `.gcm` suffix.
#
# -fmodule-mapper=<MODULE_MAP_FILE>
# A mapping file consisting of space-separated module-name, filename pairs, one per line.

mkdir mod

# Try again with explicit module map file.
echo "
MyModule mod/MyModule.gcm
MyModule:part mod/MyModule-part.gcm
MyModule:part_internal mod/MyModule-part_internal.gcm
"> module.modmap.txt

# Module partition.
# Writes 'mod/MyModule-part.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c mymodule_part.cpp

# Module partition (internal).
# Reads 'mod/MyModule-part.gcm'.
# Writes 'mod/MyModule-part_internal.gcm' even with no exports.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c mymodule_part_internal.cpp


# Module interface unit.
# Reads 'mod/MyModule-part.gcm'.
# Reads 'mod/MyModule-part_internal.gcm'.
# Writes 'mod/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c mymodule.cpp

# Module implementation unit.
# Reads 'mod/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c mymodule_impl.cpp

# Module implementation unit (for partition symbols).
# Reads 'mod/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c mymodule_part_impl.cpp

# Module consumer.
# Reads 'mod/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -fmodule-mapper=module.modmap.txt -c main.cpp

# Link the executable.  It only needs the object files.
g++-11 -o main \
  mymodule.o \
  mymodule_impl.o \
  mymodule_part.o \
  mymodule_part_impl.o \
  mymodule_part_internal.o \
  main.o
