#!/bin/sh

set -eux &&

readonly url='https://github.com/llvm/llvm-project/archive/c0da957bb05b7044bec83f8159c57b1d9ab9eb59.tar.gz'

readonly workdir="$HOME/misc/code/clang"
readonly srcdir="$workdir/clang"
readonly builddir="$workdir/build"
readonly jobs=$(($(getconf _NPROCESSORS_ONLN) * 1))

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
cmake --build . -- -j$jobs
cmake --build . --target install -- -j$jobs
rm -Rf "$workdir"
