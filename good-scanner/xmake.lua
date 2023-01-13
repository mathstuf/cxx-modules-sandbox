target("good-scanner")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("header-import.mpp",
              "macro-messiness.mpp",
              "import.mpp",
              "export.mpp",
              "mod.mpp",
              "other.mpp")

    add_defines("GOOD_SCANNER_BUILD")
    if is_kind("static") then
        add_defines("GOOD_SCANNER_STATIC_DEFINE", {public = true})
    end

    add_includedirs("$(buildir)", {public = true})

    set_configvar("NAME", "GOOD_SCANNER")
    add_configfiles("../xmake/export.h.in", {filename = "good-scanner_export.h"})

target("define-mod")
    set_kind("executable")
    add_rules("c++")

    add_files("define.mpp")

    add_defines("DEFINE=mod", "USE_MOD")

    add_deps("good-scanner")

target("define-other")
    set_kind("executable")
    add_rules("c++")

    add_files("define.mpp")
    add_defines("DEFINE=other")

    add_deps("good-scanner")

    set_policy("build.c++.modules", true)

target("export-define-x")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("export-define.mpp", "import-define.mpp")

    add_deps("good-scanner")

    add_defines("IS_X", {public = true})
    add_defines("DEFINE=x", "EXPORT_DEFINE_X_BUILD")
    if is_kind("static") then
        add_defines("EXPORT_DEFINE_X_STATIC_DEFINE")
    end

    set_configvar("NAME", "EXPORT_DEFINE_X")
    add_configfiles("../xmake/export.h.in", {filename = "export-define-x_export.h"})

    add_includedirs("$(buildir)", {public = true})

target("export-define-y")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("export-define.mpp", "import-define.mpp")

    add_deps("good-scanner")

    add_defines("DEFINE=y", "EXPORT_DEFINE_Y_BUILD")
    if is_kind("static") then
        add_defines("EXPORT_DEFINE_Y_STATIC_DEFINE", {public = true})
    end

    set_configvar("NAME", "EXPORT_DEFINE_Y")
    add_configfiles("../xmake/export.h.in", {filename = "export-define-y_export.h"})

    add_includedirs("$(buildir)", {public = true})