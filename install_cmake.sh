#!/bin/sh

set -e

readonly cmake_version="a1f4c83bd4560050251c307e828454071325b25d" # cpp-modules

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
