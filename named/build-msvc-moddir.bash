#!/usr/bin/env bash

set -e
set -x

"${BASH_SOURCE%/*}/clean.bash"

# https://devblogs.microsoft.com/cppblog/using-cpp-modules-in-msvc-from-the-command-line-part-1/

mkdir mod

# Try again with explicit module directory.
# The `-ifcOutput` flag can take a directory or a file path like `dir/filename.ifc`.

# Set to 'true' to try "module implementation partition" offered by MSVC but not in the standard.
USE_IMPL_PARTITION=false

# Module partition.
# Writes 'mod/MyModule-part.ifc'.
cl -std:c++20 -interface -ifcOutput mod/ -c mymodule_part.cpp

# Module implementation partition.
# Reads 'mod/MyModule-part.ifc'.
if $USE_IMPL_PARTITION; then
  cl -std:c++20 -ifcSearchDir mod/ -c mymodule_part_impl.cpp -DUSE_IMPL_PARTITION
fi

# Module partition (internal).
# Writes 'mod/MyModule-part_internal.ifc'
cl -std:c++20 -internalPartition -ifcOutput mod/ -c mymodule_part_internal.cpp

# Module interface unit.
# Reads 'mod/MyModule-part.ifc'.
# Reads 'mod/MyModule-part_internal.ifc'.
# Writes 'mod/MyModule.ifc'.
cl -std:c++20 -ifcSearchDir mod/ -ifcOutput mod/ -interface -c mymodule.cpp

# Module implementation unit.
# Reads 'mod/MyModule.ifc'.
cl -std:c++20 -ifcSearchDir mod/ -c mymodule_impl.cpp

if ! $USE_IMPL_PARTITION; then
  # Module implementation unit (for partition symbols).
  # Reads 'mod/MyModule.ifc'.
  cl -std:c++20 -ifcSearchDir mod/ -c mymodule_part_impl.cpp
fi

# Module consumer.
# Reads 'mod/MyModule.ifc'.
cl -std:c++20 -ifcSearchDir mod/ -c main.cpp

# Link the executable.  It only needs the object files.
link -out:main.exe \
  mymodule.obj \
  mymodule_impl.obj \
  mymodule_part.obj \
  mymodule_part_impl.obj \
  mymodule_part_internal.obj \
  main.obj

# The -reference argument can be repeated, and forms a module map.
# For example: `-reference m=m.ifc -reference m:part=m-part.ifc`
