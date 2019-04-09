#!/bin/sh

set -e

readonly cmake_version="53a29dc18c053eedcd879c79e16f6fab2811b38b" # cpp-modules

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
