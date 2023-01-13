target("generated")
    set_kind("executable")
    add_rules("c++")

    add_files("*.mpp")

    add_configfiles("*.in")
    add_files("$(buildir)/*.mpp", {force = true})

    add_includedirs("$(buildir)")