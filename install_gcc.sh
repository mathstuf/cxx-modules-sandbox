#!/bin/sh

set -e

readonly revision="269587"

readonly url="svn://gcc.gnu.org/svn/gcc/branches/c++-modules"

readonly workdir="$HOME/misc/code/gcc"
readonly srcdir="$workdir/gcc"
readonly builddir="$workdir/build"

svn checkout "-r$revision" "$url" "$srcdir"
cd "$srcdir"
git apply -p1 < "$HOME/trtbd.diff"
mkdir -p "$builddir"
cd "$builddir"
"$srcdir/configure" \
    --disable-multilib \
    --enable-languages=c,c++ \
    --prefix="$HOME/misc/root/gcc"
make -j14
make -j14 install
rm -rf "$workdir"
