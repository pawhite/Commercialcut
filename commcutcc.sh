#!/bin/csh

set path = ($path /usr/local/bin)
 
mkdir /media/comchap
mkdir /media/TSFiles

setenv CC gcc7

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
wget https://raw.githubusercontent.com/pawhite/Commercialcut/master/postcc.sh
chmod +x /postcc.sh

cd media/comchap
wget https://raw.githubusercontent.com/warrentc3/postprocessing/master/hb-dvr.json
cd /
