#!/bin/sh

set -e

readonly revision="ecea46a64e5a3b501cff5ce2e3d30027af27837b"
readonly tarball="https://github.com/gcc-mirror/gcc/archive/$revision.tar.gz"

readonly workdir="$HOME/misc/code/gcc"
readonly srcdir="$workdir/gcc"
readonly builddir="$workdir/build"
readonly njobs="$( nproc )"

mkdir -p "$workdir"
cd "$workdir"
curl -L "$tarball" > "gcc-$revision.tar.gz"
tar xf "gcc-$revision.tar.gz"
mv "gcc-$revision" "$srcdir"
cd "$srcdir"
git apply -p1 < "$HOME/trtbd.diff"
mkdir -p "$builddir"
cd "$builddir"
"$srcdir/configure" \
    --disable-multilib \
    --enable-languages=c,c++ \
    --prefix="$HOME/misc/root/gcc"
make "-j$njobs"
make "-j$njobs" install-strip
rm -rf "$workdir"
