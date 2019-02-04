#!/bin/csh

set path = ($path /usr/local/bin)

cd /usr/local
git clone https://erikkaashoek/Comskip
git clone 1 https://BrettSheleski/comchap

cd /
mkdir /media/comchap
mkdir /media/TSFiles

wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json

cd /

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