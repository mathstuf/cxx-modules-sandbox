package("extlib")
    set_homepage("https://gitlab.com/Arthapz/extlib")

    set_urls("https://github.com/Arthapz/extlib.git")
    add_versions("01-12-2023", "d68004405af3ba1cb058d4c03ae111591e093b58")

    on_install(function(package)
        import("package.tools.xmake").install(package, {kind = package:config("shared") and "shared" or "static", mode = package:is_debug() and "debug" or "release"})
    end)