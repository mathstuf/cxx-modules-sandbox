#!/bin/sh

set -e

readonly revision="269587"

readonly url="svn://gcc.gnu.org/svn/gcc/branches/c++-modules"

readonly workdir="$HOME/misc/code/gcc"
readonly srcdir="$workdir/gcc"
readonly builddir="$workdir/build"
readonly jobs=$(($(getconf _NPROCESSORS_ONLN) * 1))

svn checkout "-r$revision" "$url" "$srcdir"
cd "$srcdir"
git apply -p1 < "$HOME/trtbd.diff"
mkdir -p "$builddir"
cd "$builddir"
"$srcdir/configure" \
    --disable-multilib \
    --prefix="$HOME/misc/root/gcc"
make -j$jobs
make -j$jobs install
rm -rf "$workdir"
