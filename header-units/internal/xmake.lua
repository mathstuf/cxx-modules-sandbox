target("has-header-units")
    set_kind("$(kind)")
    add_rules("c++")

    add_headerfiles("*.h")
    add_files("*.mpp")

    on_config(function(target)
        if target:has_tool("cxx", "gcc", "gxx") then
            print("GCC trtbd build ! disabling has-header-units target")
            target:set("default", false)
        end
    end)