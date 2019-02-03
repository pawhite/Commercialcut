#!/bin/csh

set path = ($path /usr/local/bin)

cd /

mkdir /media/comchap
mkdir /media/TSFiles

pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y argtable
pkg install -y nano
pkg install -y ffmpeg
pkg install -y git
pkg install -y gcc7
pkg install -y handbrake
setenv CC gcc7

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf 

cd /usr/local 
wget https://github.com/erikkaashoek/Comskip
cd /usr/local/Comskip
./autogen.sh
./configure
make
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /usr/local 
wget https://github.com/BrettSheleski/comchap

cd /
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/postj.sh
chmod +x /postj.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json
cd /
