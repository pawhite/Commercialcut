#!/bin/csh

cd /
pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y argtable
pkg install -y nano
pkg install -y ffmpeg
pkg install -y bash
pkg install -y gcc7
pkg install -y handbrake

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf 

cd /usr/local/libdata/pkgconfig/
git https://github.com/pawhite/Commercialcut/argtable2.pc

cd /
setenv CC gcc7

mkdir /usr/local/comchap
mkdir /usr/local/Comskip
mkdir /media/comchap
mkdir /media/TSFiles
cd /usr/local 
git clone --depth 1 git://github.com/erikkaashoek/Comskip
cd /usr/local/Comskip
./autogen.sh
./configure
make
git https://github.com/pawhite/Commercialcut/comskip.ini

cd /usr/local 
git clone --depth 1 https://github.com/BrettSheleski/comchap

ln -s /usr/local/bin/nano /usr/bin/nano
ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
ln -s /usr/local/Comskip/comskip /usr/bin/comskip
ln -s /usr/local/comchap/comcut /usr/bin/comcut
ln -s /usr/local/comchap/comchap /usr/bin/comchap

cd /
git https://github.com/pawhite/Commercialcut/post.sh
chmod +x /post.sh

cd media/comchap
git https://github.com/warrentc3/postprocessing/hb-dvr.json
cd /


