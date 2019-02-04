#!/bin/csh

set path = ($path /usr/local/bin)

setenv CC gcc7

cd /usr/local/Comskip
./autogen.sh
./configure
make
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini

cd /

