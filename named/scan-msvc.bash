#!/usr/bin/env bash

set -e
set -x

"${BASH_SOURCE%/*}/clean.bash"

# Set to 'true' to try "module implementation partition" offered by MSVC but not in the standard.
USE_IMPL_PARTITION=false

# Module partition.
# primary-output: mymodule_part.obj
# outputs: MyModule-part.ifc
# provides: MyModule:part
cl -std:c++20 -scanDependencies mymodule_part-default.json -c mymodule_part.cpp
cl -std:c++20 -interface -scanDependencies mymodule_part-interface.json -c mymodule_part.cpp

# Module implementation partition.
# primary-output: mymodule_part_impl.obj
# outputs: MyModule-part.ifc
# provides: MyModule:part
# The json file cannot be distinguished from the main module partition in 'mymodule_part.cpp'.
# It should look more like the result for a module implementation unit (mymodule_impl.cpp):
#   primary-output: mymodule_part_impl.obj
#   requires: MyModule:part
if $USE_IMPL_PARTITION; then
  cl -std:c++20 -scanDependencies mymodule_part_impl-default.json -c mymodule_part_impl.cpp -DUSE_IMPL_PARTITION
fi

# Module partition (internal).
# primary-output: mymodule_part_internal.obj
# outputs: MyModule-part_internal.ifc
# provides: MyModule:part_internal
cl -std:c++20 -scanDependencies mymodule_part_internal-default.json -c mymodule_part_internal.cpp
cl -std:c++20 -scanDependencies mymodule_part_internal-internalPartition.json -internalPartition -c mymodule_part_internal.cpp

# Module interface unit.
# primary-output: mymodule.obj
# outputs: MyModule.ifc
# provides: MyModule
# requires: MyModule:part MyModule:part_internal
cl -std:c++20 -scanDependencies mymodule-default.json -c mymodule.cpp
cl -std:c++20 -scanDependencies mymodule-interface.json -interface -c mymodule.cpp

# Module implementation unit.
# primary-output: mymodule_impl.obj
# requires: MyModule
cl -std:c++20 -scanDependencies mymodule_impl-default.json -c mymodule_impl.cpp

if ! $USE_IMPL_PARTITION; then
  cl -std:c++20 -scanDependencies mymodule_part_impl-default.json -c mymodule_part_impl.cpp
fi

# Module consumer.
# primary-output: main.obj
# requires: MyModule
cl -std:c++20 -scanDependencies main-default.json -c main.cpp
