#!/bin/csh

cd /
set path = ($path /usr/local/bin)

pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y argtable
pkg install -y nano
pkg install -y ffmpeg
pkg install -y gcc7
pkg install -y handbrake

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf

mkdir /media/comchap
mkdir /media/TSFiles

wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh

setenv CC gcc7

cd /usr/local/Comskip
./autogen.sh
./configure
make
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json

cd /