target("with_named_modules")
    set_kind("binary")

    -- in XMake we don't support .cpp as interface module / internal partition (only ".mpp"/".mxx"/".cppm"/".ixx" atm)
    on_config(function(target)
        local module_path = path.join(target:autogendir(), "cpp_to_mpp")
        if target:is_plat("windows") then
            if os.isdir(module_path) then
                os.rm(module_path)
            end
        end
        os.cp("$(scriptdir)/depmodule1.cpp", path.join(module_path, "depmodule1.mpp"), {symlink = true})
        os.cp("$(scriptdir)/depmodule2.cpp", path.join(module_path, "depmodule2.mpp"), {symlink = true})
        os.cp("$(scriptdir)/mymodule_part.cpp", path.join(module_path, "mymodule_part.mpp"), {symlink = true})
        os.cp("$(scriptdir)/mymodule.cpp", path.join(module_path, "mymodule.mpp"), {symlink = true})
        os.cp("$(scriptdir)/mymodule_part_internal.cpp", path.join(module_path, "mymodule_part_internal.mpp"), {symlink = true})

        target:add("files", path.join(module_path, "*.mpp"))
        target:fileconfig_add(path.join(module_path, "mymodule_part_internal.mpp"), {values = {["internalpartition"] = true}})
    end)

    add_files("mymodule_impl.cpp", "main.cpp", "mymodule_part_impl.cpp")

    if is_plat("windows") then
        -- add_defines("USE_IMPL_PARTITION")
    end

    set_policy("build.c++.modules", true)