#!/bin/csh

set path = ($path /usr/local/bin)

set filename = `printf "%s " $1:t:r`
set grab = `printf "%s " $1:h`
set a = `echo "$filename".ts`
set b = `echo "$grab/$filename"_cut.ts`
set c = `echo "$grab/$filename".mkv`
sleep 10

while (1)
if ( ! -e "$b" ) then 
echo "Running Comcut"
/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip/comskip.ini "$1" "$b"
echo "Comcut complete" 
else
echo "Comcut already done" 
endif 
break 
end

while (1)
if ( ! `pgrep HandBrakeCLI` ) then 
break 
endif 
echo "HandBrakeCLI is still running. Will try again in a minute." 
sleep 60 
end

HandBrakeCLI --input "$b" --output "$c" --format mkv --encoder x264 --quality 18 --loose-anamorphic --decomb fast --x264-preset medium --h264-profile high --h264-level 4.1 --aencoder ac3 --mixdown 5point1

rm "$b"
mv "$1" "/media/ts_archive/$a"




