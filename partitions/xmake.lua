target("partitions")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("module.mpp", "parta.mpp")
    add_files("partb.mpp", "impl.mpp", {values = {["msvc.internalpartition"] = true}})
    set_policy("build.c++.modules", true)