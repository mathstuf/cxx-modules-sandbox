add_requires("extlib")

target("use-ext-mods")
    set_kind("$(kind)")
    add_rules("c++")

    add_files("*.mpp")
    add_packages("extlib")