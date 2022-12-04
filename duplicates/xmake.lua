target("duplicates")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("*.mpp")

    add_defines("DUPLICATES_BUILD")
    if is_kind("static") then
        add_defines("DUPLICATES_STATIC_DEFINE", {public = true})
    end

    add_includedirs("$(buildir)", {public = true})

    set_configvar("NAME", "DUPLICATES")
    add_configfiles("../xmake/export.h.in", {filename = "duplicates_export.h"})