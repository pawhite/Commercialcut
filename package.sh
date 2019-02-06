#!/bin/csh

set path = ($path /usr/local/bin)

cd /

echo y | pkg install bash
echo y | pkg install autoconf
echo y | pkg install automake
echo y | pkg install libtool
echo y | pkg install argtable
echo y | pkg install nano
echo y | pkg install ffmpeg
echo y | pkg install gcc7
echo y | pkg install handbrake

echo y | pkg set -o devel/pkg-config:devel/pkgconf
echo y | pkg install -f devel/pkgconf

git clone https://github.com/erikkaashoek/Comskip
git clone https://github.com/BrettSheleski/comchap

setenv CC gcc7

cd /Comskip
./autogen.sh
./configure
make
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /
mkdir /media/ts_archive
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh


