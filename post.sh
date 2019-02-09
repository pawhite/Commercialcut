#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set grab = `printf "%s " $1:h`
set a = `echo "$grab/$show"_cut.ts` 
set b = `echo "$grab/$show".mkv`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip-master/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip-master/comskip.ini "$1" "$a" 

/usr/local/bin/HandBrakeCLI --input "$a" --output "$b" --format mkv --encoder x264 --quality 18 --loose-anamorphic --decomb fast --x264-preset medium --h264-profile high --h264-level 4.1 --aencoder ac3 --mixdown 5point1

rm "$a"
mv "$1" "/media/TSFiles/$show.ts"




