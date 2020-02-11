#!/bin/sh

set -e

readonly ninja_version="1.10.0"

readonly url="https://github.com/ninja-build/ninja"

readonly workdir="$HOME/misc/code/ninja"
readonly srcdir="$workdir"

mkdir -p "$workdir"
cd "$workdir"

curl -LO "$url/releases/download/v$ninja_version/ninja-linux.zip"
"$HOME/misc/root/cmake/bin/cmake" -E tar xf "ninja-linux.zip"
install -m 755 ninja "$HOME/misc/root/cmake/bin/ninja"
rm -rf "$workdir"
