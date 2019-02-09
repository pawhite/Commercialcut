#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts`
set grab = `printf "%s " $1:h`
set a = `echo "$show".ts`
set b = `echo "$grab/$show"_cut.ts`
set c = `echo "$grab/$show".mkv`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip/comskip.ini "$1" "$b"

/usr/local/bin/HandBrakeCLI --input "$b" --output "$c" --format mkv --encoder x264 --quality 18 --loose-anamorphic --decomb fast --x264-preset medium --h264-profile high --h264-level 4.1 --aencoder ac3 --mixdown 5point1
#/usr/local/bin ffmpeg i "$1" -vf yadif -c:v libx264 -preset slow -crf 17 -c:a copy '/media/Recordings/"$show.mkv"'

rm $b
mv "$1" "/media/ts_archive/$a"






