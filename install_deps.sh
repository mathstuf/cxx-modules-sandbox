#!/bin/sh

set -e

readonly git_deps="git-core"
readonly cmake_deps="openssl-devel make"
readonly ninja_deps="re2c"
readonly gcc_deps="subversion gcc-c++ mpfr-devel libmpc-devel isl-devel flex bison file findutils"
readonly clang_deps="cmake ninja-build"

dnf install -y \
    $git_deps \
    $cmake_deps \
    $ninja_deps \
    $gcc_deps \
    $clang_deps
dnf clean all
