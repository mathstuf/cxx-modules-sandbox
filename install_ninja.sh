#!/bin/sh

set -e

readonly ninja_version="kitware-staged-features"

readonly url="https://github.com/Kitware/ninja"

readonly workdir="$HOME/misc/code/ninja"
readonly srcdir="$workdir"

git clone "$url" "$srcdir"
cd "$srcdir"
git checkout "$ninja_version"
python3 "$srcdir/configure.py" \
    --bootstrap \
    --verbose
install -m 755 ninja "$HOME/misc/root/cmake/bin/ninja"
rm -rf "$workdir"
