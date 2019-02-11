#!/bin/csh

set path = ($path /usr/local/bin)

set show = `basename "$1" .ts` 
set grab = `printf "%s " $1:h`
set a = `echo "$show"_cut.ts`
set b = `echo "$grab/$show".mkv`
sleep `echo $$%10 | bc`

/comchap/comcut --ffmpeg=/usr/local/bin/ffmpeg --comskip=/Comskip-master/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/Comskip-master/comskip.ini "$1" "$a" 

/usr/local/bin/ffmpeg -i "$a" -vf yadif -c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k "$b"

rm "$a"
mv "$1" "/media/TSFiles/$show.ts"

/usr/bin/find /media/Recordings/ -type f -name "*Civilizations*" -exec /bin/mv {} "/media/Recorded TV/Civilizations (2018)/" \;/usr/bin/find /media/Recordings/ -type f -name "*Shakespeare Uncovered*.mkv" -exec /bin/mv {} "/media/Recorded TV/Shakespeare Uncovered/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Shakespeare Uncovered*" -exec /bin/mv {} "/media/Recorded TV/Shakespeare Uncovered/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Brooklyn Nine-Nine*" -exec /bin/mv {} "/media/Recorded TV/Brooklyn Nine-Nine/" \;
/usr/bin/find /media/Recordings/ -type f -name "*I Am the Night*" -exec /bin/mv {} "/media/Recorded TV/I Am the Night/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Drunk History*" -exec /bin/mv {} "/media/Recorded TV/Drunk History/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Elementary*" -exec /bin/mv {} "/media/Recorded TV/Elementary/" \;
/usr/bin/find /media/Recordings/ -type f -name "*The Passage*" -exec /bin/mv {} "/media/Recorded TV/The Passage/" \;
/usr/bin/find /media/Recordings/ -type f -name "*The Orville*" -exec /bin/mv {} "/media/Recorded TV/The Orville/" \;
/usr/bin/find /media/Recordings/ -type f -name "*The Ernie Kovacs Show*" -exec /bin/mv {} "/media/Recorded TV/The Ernie Kovacs Show (1952)/" \;
