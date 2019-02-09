#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set grab = `printf "%s " $1:h`
set a = `echo "$show".ts`
set b = `echo "$grab/$show"_cut.ts` 
set c = `echo "$grab/$show".mkv`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip-master/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip-master/comskip.ini "$b" 

/usr/local/bin/HandBrakeCLI --input "$b" --output "$c" --format mkv --encoder x264 --quality 18 --loose-anamorphic --decomb fast --x264-preset medium --h264-profile high --h264-level 4.1 --aencoder ac3 --mixdown 5point1

rm $b
mv "$1" "/media/ts_archive/$a"




