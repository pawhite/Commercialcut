#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set grab = `printf "%s " $1:h`
set a = `echo "$grab/$show"_cut.ts` 
set b = `echo "$grab/$show".mkv`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip/comskip.ini "$1" "$a" 

/usr/local/bin/ffmpeg -i "$a" -vf yadif -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k "$b"

rm "$a"
mv "$1" "/media/ts-archive/$show.ts"




