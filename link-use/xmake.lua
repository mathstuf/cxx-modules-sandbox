target("link-use")
    set_kind("binary")
    add_rules("c++")

    add_files("*.mpp")

    add_deps("simple")