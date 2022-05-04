#!/usr/bin/env bash

set -e
set -x

"${BASH_SOURCE%/*}/clean.bash"

# https://devblogs.microsoft.com/cppblog/using-cpp-modules-in-msvc-from-the-command-line-part-1/

# Set to 'true' to try "module implementation partition" offered by MSVC but not in the standard.
USE_IMPL_PARTITION=false

# Module partition.
# Writes 'MyModule-part.ifc'.
cl -std:c++20 -interface -c mymodule_part.cpp

# Module implementation partition.
# Reads 'MyModule-part.ifc'.
if $USE_IMPL_PARTITION; then
  cl -std:c++20 -c mymodule_part_impl.cpp -DUSE_IMPL_PARTITION
fi

# Module partition (internal).
# Writes 'MyModule-part_internal.ifc'
cl -std:c++20 -internalPartition -c mymodule_part_internal.cpp

# Module interface unit.
# Reads 'MyModule-part.ifc'.
# Reads 'MyModule-part_internal.ifc'.
# Writes 'MyModule.ifc'.
cl -std:c++20 -interface -c mymodule.cpp

# Module implementation unit.
# Reads 'MyModule.ifc'.
cl -std:c++20 -c mymodule_impl.cpp

if ! $USE_IMPL_PARTITION; then
  # Module implementation unit (for partition symbols).
  # Reads 'MyModule.ifc'.
  cl -std:c++20 -c mymodule_part_impl.cpp
fi

# Module consumer.
# Reads 'MyModule.ifc'.
cl -std:c++20 -c main.cpp

# Link the executable.  It only needs the object files.
link -out:main.exe \
  mymodule.obj \
  mymodule_impl.obj \
  mymodule_part.obj \
  mymodule_part_impl.obj \
  mymodule_part_internal.obj \
  main.obj
