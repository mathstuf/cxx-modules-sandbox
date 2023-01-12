add_requires("extlib")

target("use-ext-mods")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("*.mpp")
    add_packages("extlib")

    on_config(function(target)
        if target:has_tool("cxx", "gcc", "gxx") then
            print("GCC trtbd build ! disabling use-ext-mods target")
            target:set("default", false)
        end
    end)