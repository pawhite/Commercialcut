#!/bin/csh

set path = ($path /usr/local/bin)

cd /

pkg install -y git
pkg install -y bash
pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y argtable
pkg install -y nano
pkg install -y ffmpeg
pkg install -y gcc7
pkg install -y handbrake

echo y | pkg set -o devel/pkg-config:devel/pkgconf
echo y | pkg install -f devel/pkgconf

fetch https://githubusercontent.com/pawhite/Commercialcut/master/comcompile.sh
chmod +x /comcompile.sh
./compile.sh

cd /
mkdir /media/ts_archive
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh


