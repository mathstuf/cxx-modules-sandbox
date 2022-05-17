#!/usr/bin/env bash
set -e
set -x

"${BASH_SOURCE%/*}/clean.bash"

# https://devblogs.microsoft.com/cppblog/using-cpp-modules-in-msvc-from-the-command-line-part-1/

# Set to 'true' to try "module implementation partition" offered by MSVC but not in the standard.
USE_IMPL_PARTITION=false

mkdir mod

# Module partition.
# Writes 'mod/MyModule-part.ifc'.
cl -std:c++20 -interface -c mymodule_part.cpp \
              -ifcOutput mod/MyModule-part.ifc

if $USE_IMPL_PARTITION; then
  # Module implementation partition (MSVC-specific).
  # Reads 'mod/MyModule-part.ifc'.
  cl -std:c++20 -c mymodule_part_impl.cpp -DUSE_IMPL_PARTITION \
                -reference MyModule:part=mod/MyModule-part.ifc
fi

# Module partition (internal).
# Writes 'mod/MyModule-part_internal.ifc'
cl -std:c++20 -internalPartition -c mymodule_part_internal.cpp \
              -ifcOutput mod/MyModule-part_internal.ifc

# Module interface unit.
# Writes 'mod/DepModule1.ifc'.
cl -std:c++20 -interface -c depmodule1.cpp \
              -ifcOutput mod/DepModule1.ifc

# Module interface unit.
# Writes 'mod/DepModule2.ifc'.
cl -std:c++20 -interface -c depmodule2.cpp \
              -ifcOutput mod/DepModule2.ifc

# Module interface unit.
# Reads 'mod/MyModule-part.ifc'.
# Reads 'mod/MyModule-part_internal.ifc'.
# Reads 'mod/DepModule1.ifc'.
# Reads 'mod/DepModule2.ifc'.
# Writes 'mod/MyModule.ifc'.
cl -std:c++20 -interface -c mymodule.cpp \
              -reference MyModule:part=mod/MyModule-part.ifc \
              -reference MyModule:part_internal=mod/MyModule-part_internal.ifc \
              -reference DepModule1=mod/DepModule1.ifc \
              -reference DepModule2=mod/DepModule2.ifc \
              -ifcOutput mod/MyModule.ifc

# Module implementation unit.
# Reads 'mod/MyModule.ifc'.
# Reads 'mod/MyModule-part.ifc' (due to MSVC by-reference model to).
# Reads 'mod/MyModule-part_internal.ifc' (due to MSVC by-reference model to).
# Reads 'mod/DepModule1.ifc'.
# Reads 'mod/DepModule2.ifc'.
cl -std:c++20 -c mymodule_impl.cpp \
              -reference MyModule=mod/MyModule.ifc \
              -reference MyModule:part=mod/MyModule-part.ifc \
              -reference MyModule:part_internal=mod/MyModule-part_internal.ifc \
              -reference DepModule1=mod/DepModule1.ifc \
              -reference DepModule2=mod/DepModule2.ifc

if ! $USE_IMPL_PARTITION; then
  # Module implementation unit (for partition symbols).
  # Reads 'mod/MyModule.ifc'.
  # Reads 'mod/MyModule-part.ifc' (due to MSVC by-reference model to).
  # Reads 'mod/MyModule-part_internal.ifc' (due to MSVC by-reference model to).
  # Reads 'mod/DepModule1.ifc'.
  # Reads 'mod/DepModule2.ifc'.
  cl -std:c++20 -c mymodule_part_impl.cpp \
                -reference MyModule=mod/MyModule.ifc \
                -reference MyModule:part=mod/MyModule-part.ifc \
                -reference MyModule:part_internal=mod/MyModule-part_internal.ifc \
                -reference DepModule1=mod/DepModule1.ifc \
                -reference DepModule2=mod/DepModule2.ifc
fi

# Module consumer.
# Reads 'mod/MyModule.ifc'.
# Reads 'mod/MyModule-part.ifc' (due to MSVC by-reference model to).
# Reads 'mod/DepModule1.ifc'.
# Does not read 'mod/DepModule2.ifc' (unlike GCC, which does read it).
cl -std:c++20 -c main.cpp \
              -reference MyModule=mod/MyModule.ifc \
              -reference MyModule:part=mod/MyModule-part.ifc \
              -reference DepModule1=mod/DepModule1.ifc

# Link the executable.  It only needs the object files.
link -out:main.exe \
  mymodule.obj \
  mymodule_impl.obj \
  mymodule_part.obj \
  mymodule_part_impl.obj \
  mymodule_part_internal.obj \
  depmodule1.obj \
  depmodule2.obj \
  main.obj
