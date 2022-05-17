// Module Partition (internal)
module MyModule:part_internal;

// This is an internal module partition.
// It is a module partition that can be imported
// within the module itself, but not exported from it.
// With MSVC, compile this using `-internalPartition`.

// Define a function usable elsewhere in the module implementation.
// This is not exported from the module.
void part_internal_f() {}
