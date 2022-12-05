target("link-use-mask")
    set_kind("binary")
    add_rules("c++")

    add_files("*.mpp")

    add_deps("simple", "duplicates")

target("link-use-mask-reverse")
    set_kind("binary")
    add_rules("c++")

    add_files("*.mpp")

    add_deps("duplicates", "simple")

    set_values("should_fail", true)