#!/bin/sh

set -e

readonly cmake_version="cpp-modules-20190716.1"

readonly url="https://gitlab.kitware.com/ben.boeckel/cmake.git"

readonly workdir="$HOME/misc/code/cmake"
readonly srcdir="$workdir/cmake"
readonly builddir="$workdir/build"
readonly njobs="$(( $( getconf _NPROCESSORS_ONLN ) * 1 ))"

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
