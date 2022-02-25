#!/bin/sh

set -e

readonly cmake_version="cpp-modules-20220225.0"

readonly url="https://gitlab.kitware.com/ben.boeckel/cmake.git"

readonly workdir="$HOME/misc/code/cmake"
readonly srcdir="$workdir/cmake"
readonly builddir="$workdir/build"
readonly njobs="$( nproc )"

git clone "$url" "$srcdir"
cd "$srcdir"
git checkout "$cmake_version"
mkdir -p "$builddir"
cd "$builddir"
"$srcdir/bootstrap" \
    --parallel="$njobs" \
    --prefix="$HOME/misc/root/cmake"
make "-j$njobs" install
rm -rf "$workdir"
