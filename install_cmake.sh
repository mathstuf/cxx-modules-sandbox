#!/bin/sh

set -e

readonly cmake_version="gcc-modules"

readonly url="https://gitlab.kitware.com/ben.boeckel/cmake.git"

readonly workdir="$HOME/misc/code/cmake"
readonly srcdir="$workdir/cmake"
readonly builddir="$workdir/build"

git clone "$url" "$srcdir"
cd "$srcdir"
git checkout "$cmake_version"
mkdir -p "$builddir"
cd "$builddir"
"$srcdir/bootstrap" \
    --parallel=14 \
    --prefix="$HOME/misc/root/cmake"
make -j14 install
rm -rf "$workdir"
