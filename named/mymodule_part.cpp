// Module Partition
export module MyModule:part;

// Export a function from this module partition.  Implement it here.
export void part_f() {}

// Export functions from this module partition.  Implemented elsewhere.
export void part_g();
export void part_g_impl();
