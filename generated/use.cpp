import gen;

extern int genimport();

int main(int argc, char* argv[]) {
    (void)argc;
    (void)argv;

    return gen() + genimport();
}
