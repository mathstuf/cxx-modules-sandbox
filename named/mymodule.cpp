// Module Interface Unit
export module MyModule;

// Import and re-export a module partition.
export import :part;

// Import an internal module partition.
import :part_internal;

// Export a function from this module.  Implement it here.
export void mod_f()
{
  // The implementation can use internal module partition
  // functions even though they are not exported.
  part_internal_f();
}

// Export a function from this module.  Implemented elsewhere.
export void mod_g();
