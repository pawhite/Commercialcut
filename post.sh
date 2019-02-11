#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set grab = `printf "%s " $1:h`
set a = `echo "$grab/$show".mkv`
sleep `echo $$%10 | bc`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip/comskip.ini "$1" 

/usr/local/bin/ffmpeg -i "$1" -vf yadif -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k "$a"






