#!/bin/sh

set -e

readonly revision="50bc9185c2821350f0b785d6e23a6e9dcde58466" # 11.1.0
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
