target("has-header-units")
    set_kind("$(kind)")
    add_rules("c++")

    add_headerfiles("*.h")
    add_files("*.mpp")