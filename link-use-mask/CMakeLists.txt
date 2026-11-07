add_executable(link-use-mask
    use.cpp)
# Should use "simple"'s `M` module since it is first in the link list.
target_link_libraries(link-use-mask
    PRIVATE
        simple
        duplicates)
add_test(NAME link-use-mask COMMAND link-use-mask)

add_executable(link-use-mask-reverse
    use.cpp)
# Should use "duplicate"'s `M` module since it is first in the link list.
target_link_libraries(link-use-mask-reverse
    PRIVATE
        duplicates
        simple)
add_test(NAME link-use-mask-reverse COMMAND link-use-mask-reverse)
set_tests_properties(link-use-mask-reverse
    PROPERTIES
        WILL_FAIL TRUE)
