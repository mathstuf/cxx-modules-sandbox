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

# Module partition.
# Writes 'gcm.cache/MyModule-part.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -c mymodule_part.cpp

# Module partition (internal).
# Reads 'gcm.cache/MyModule-part.gcm'.
# Writes 'gcm.cache/MyModule-part_internal.gcm' even with no exports.
g++-11 -x c++ -std=c++20 -fmodules-ts -c mymodule_part_internal.cpp

# Module interface unit.
# Reads 'gcm.cache/MyModule-part.gcm'.
# Reads 'gcm.cache/MyModule-part_internal.gcm'.
# Writes 'gcm.cache/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -c mymodule.cpp

# Module implementation unit.
# Reads 'gcm.cache/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -c mymodule_impl.cpp

# Module implementation unit (for partition symbols).
# Reads 'gcm.cache/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -c mymodule_part_impl.cpp

# Module consumer.
# Reads 'gcm.cache/MyModule.gcm'.
g++-11 -x c++ -std=c++20 -fmodules-ts -c main.cpp

# Link the executable.  It only needs the object files.
g++-11 -o main \
  mymodule.o \
  mymodule_impl.o \
  mymodule_part.o \
  mymodule_part_impl.o \
  mymodule_part_internal.o \
  main.o
