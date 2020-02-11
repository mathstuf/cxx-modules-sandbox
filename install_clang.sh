#!/bin/sh

set -e

readonly url='https://github.com/llvm/llvm-project/archive/65ac68ec3419abd98731e0c434229239e1563045.tar.gz'

readonly workdir="$HOME/misc/code/clang"
readonly srcdir="$workdir/clang"
readonly builddir="$workdir/build"
readonly njobs="$( nproc )"

curl -fLs "$url" | tar xz --strip-components=1 --one-top-level="$srcdir"
mkdir -p "$builddir"
cd "$builddir"
cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$HOME/misc/root/clang" \
    -DBUILD_SHARED_LIBS=ON \
    -DLLVM_PARALLEL_LINK_JOBS:STRING=1 \
    -DLLVM_TARGETS_TO_BUILD=Native \
    -DLLVM_ENABLE_PROJECTS='clang' \
    "$srcdir/llvm"
cmake --build . -- "-j$njobs"
cmake --build . --target install -- "-j$njobs"
rm -rf "$workdir"
