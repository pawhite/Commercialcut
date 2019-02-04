#!/bin/csh

set path = ($path /usr/local/bin)

cd/

git clone https://github.com/erikkaashoek/Comskip
git clone https://github.com/BrettSheleski/comchap

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

fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh

setenv CC gcc7

cd /Comskip
./autogen.sh
./configure
make
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /media/comchap
fetch https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json

cd /
portsnap fetch extract
cd /usr/ports/audio/lame
make install clean

cd /