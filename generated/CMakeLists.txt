function (generate name)
    add_custom_command(
        OUTPUT  "${CMAKE_CURRENT_BINARY_DIR}/${name}"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${name}.in"
        COMMAND "${CMAKE_COMMAND}"
                -E copy_if_different
                "${CMAKE_CURRENT_SOURCE_DIR}/${name}.in"
                "${CMAKE_CURRENT_BINARY_DIR}/${name}"
        COMMENT "Copying ${name}")
endfunction ()

generate(gen-export.cpp)
generate(gen-import.cpp)

add_executable(generated
    "${CMAKE_CURRENT_BINARY_DIR}/gen-export.cpp"
    "${CMAKE_CURRENT_BINARY_DIR}/gen-import.cpp"
    use.cpp)
add_test(NAME generated COMMAND generated)
