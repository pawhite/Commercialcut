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

ln -s /usr/local/bin/nano /usr/bin/nano
ln -s /usr/local/bin/ffmpeg /usr/bin/ffmpeg
ln -s /usr/local/Comskip/comskip /usr/bin/comskip
ln -s /usr/local/comchap/comcut /usr/bin/comcut
ln -s /usr/local/comchap/comchap /usr/bin/comchap

cd /
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/postcc.sh
chmod +x /postcc.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json
cd /
pkg install -y handbrake

