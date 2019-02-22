#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set head = `dirname "$1"`
set a = `echo "$head/$show".mkv`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip/comskip.ini "$1"

/usr/local/bin/ffmpeg -i "$1" -vf yadif -c:v libx264 -preset slow -crf 18 -max_muxing_queue_size 1024 -c:a copy "$a"

mv "$1" "/media/ts_archive/$show.ts"




