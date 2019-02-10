#!/bin/csh

set path = ($path /usr/local/bin)

cd /

#Install packages
pkg install -y git
pkg install -y bash
pkg install -y argtable
pkg install -y autoconf
pkg install -y automake
pkg install -y libtool
pkg install -y ffmpeg

#Set up pkgconf and install
echo y | pkg set -o devel/pkg-config:devel/pkgconf
echo y | pkg install -f devel/pkgconf

#Set compiler to use clang
setenv CC clang

#download Comskip and comchap from github 
/usr/local/bin/git clone https://github.com/erikkaashoek/Comskip
/usr/local/bin/git clone https://github.com/BrettSheleski/comchap

#Compile comskip and download/add comskip.ini to guide the commercial cutting process
cd /Comskip
./autogen.sh
./configure
make
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

#Create a directory to place the original recording after commercial cutting and add the post-processing script
cd /
mkdir /media/ts_archive
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/post.sh
chmod +x /post.sh


