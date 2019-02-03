#!/bin/csh

set path = ($path /usr/local/bin)

cd /

pkg install -y git
sleep 180
pkg install -y autoconf
sleep 10
pkg install -y automake
sleep 12
pkg install -y libtool
sleep 3
pkg install -y argtable
sleep 5
pkg install -y nano
sleep 3
pkg install -y ffmpeg
sleep 180
pkg install -y gcc7
sleep 180
pkg install -y handbrake
sleep180

pkg set -o devel/pkg-config:devel/pkgconf
pkg install -f devel/pkgconf


setenv CC gcc7

mkdir /media/comchap
mkdir /media/TSFiles

cd /usr/local 
git clone --depth 1 https://github.com/erikkaashoek/Comskip
cd /usr/local/Comskip
./autogen.sh
./configure
make
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /usr/local 
get clone --depth 1 https://github.com/BrettSheleski/comchap

cd /
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/postj.sh
chmod +x /postj.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json
cd /
