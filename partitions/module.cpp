export module module;
export import :parta;
import :partb;
import :impl;

export int useparta() {
    return a();
}

export int usepartb() {
    return b();
}

export int useimpl() {
    return impl();
}
