#ifdef USE_IMPL_PARTITION
// Module Implementation Partition (MSVC-specific)
// In the C++ standard, module partitions are not supposed to
// have separate implementation sources like this.
// Compile this with MSVC *without* using `-internalPartition`.
module MyModule:part;
#else
// Module Implementation Unit
// Implements functions from the module interface or module partition.
module MyModule;
#endif

// Implement a function declared in a module partition.
void part_g_impl() {}
