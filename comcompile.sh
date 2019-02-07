#!/bin/csh

set path = ($path /usr/local/bin)

cd /

git clone https://github.com/erikkaashoek/Comskip
git clone https://github.com/BrettSheleski/comchap

cd /Comskip
./autogen.sh
./configure
make
fetch https://raw.githubusercontent.com/pawhite/Commercialcut/master/comskip.ini


