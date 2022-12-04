set_xmakever("2.7.3")
set_project("cxx-modules-sandbox")
add_rules("mode.debug", "mode.release")

set_languages("c++latest", "clatest")
set_values("msvc.modules.stdifcdir", true)

local libraries = {
    "duplicates",
    "duplicates_same_dir",
    "simple",
    "partitions",
    "generated",
    "header-units",
    "link-use",
    "link-use-mask",
    "named"
}

for _, name in ipairs(libraries) do
    includes(path.join(name, "xmake.lua"))
end