#!/bin/csh

set path = ($path /usr/local/bin)

cd /

yes | set
yes | install

mkdir /media/comchap
mkdir /media/TSFiles

pkg install autoconf
pkg install automake
pkg install libtool
pkg install argtable
pkg install nano
pkg install ffmpeg
pkg install git
pkg install gcc7
pkg install handbrake
setenv CC gcc7

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf 

cd /usr/local 
git clone --depth 1 https://github.com/erikkaashoek/Comskip
cd /usr/local/Comskip
./autogen.sh
./configure
make
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /usr/local 
git clone --depth 1 https://github.com/BrettSheleski/comchap

cd /
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/postj.sh
chmod +x /postj.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json
cd /
