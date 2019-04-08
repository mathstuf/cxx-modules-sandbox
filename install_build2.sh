#!/bin/sh

set -eux &&

readonly url='https://stage.build2.org/0'
readonly version=0.11.0-a.0
readonly cppget_org_cert_fingerprint=37:CE:2C:A5:1D:CF:93:81:D7:07:46:AD:66:B3:C3:90:83:B8:96:9E:34:F0:E7:B3:A2:B0:6C:EF:66:A4:BE:65

readonly workdir="$HOME/misc/code/build2"
readonly jobs=$(($(getconf _NPROCESSORS_ONLN) * 1))

mkdir -p "$workdir"
cd "$workdir"
script=build2-install-$version-stage.sh
curl -sSfO "$url/$version/$script"
sh $script --yes --trust $cppget_org_cert_fingerprint --sudo false --jobs $jobs \
	"$HOME/misc/root/build2"
rm -Rf "$workdir"
