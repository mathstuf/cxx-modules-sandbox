// Module consumer.
import MyModule;

// Use functions exported by the module interface unit.
int main() {
  mod_f();
  mod_g();
  part_f();
  part_g();
  part_g_impl();
  return 0;
}
