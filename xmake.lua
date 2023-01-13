set_xmakever("2.7.3")
set_project("cxx-modules-sandbox")
add_rules("mode.debug", "mode.release")

set_languages("c++latest", "clatest")
add_repositories("repo repo")

local targets = {
    "duplicates",
    "duplicates-same-dir",
    "simple",
    "partitions",
    "generated",
    "header-units",
    "link-use",
    "link-use-mask",
    "named"
}

for _, name in ipairs(targets) do
    includes(path.join(name, "xmake.lua"))
end

includes("tests.lua")