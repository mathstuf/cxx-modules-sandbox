target("simple")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("*.mpp")
    add_defines("SIMPLE_BUILD")
    if is_kind("static") then
        add_defines("SIMPLE_STATIC_DEFINE", {public = true})
    end

    add_includedirs("$(buildir)", {public = true})

    set_configvar("NAME", "SIMPLE")
    add_configfiles("../xmake/export.h.in", {filename = "simple_export.h"})