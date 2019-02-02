#!/bin/csh

set path = ($path /usr/local/bin)

set filename = `printf "%s " $1:t:r`
set grab = `printf "%s " $1:h`
set a = `echo "$filename".ts`
set b = `echo "$grab/$filename"_cut.ts`
set c = `echo "$grab/$filename".mp4`
set d = 'echo "$grab/filename".srt'
sleep 10

while (1)
if ( ! -e "$b" ) then 
echo "Running Comcut"
comcut --ffmpeg=/usr/bin/ffmpeg --comskip=/usr/bin/comskip --lockfile=/tmp/comchap.lock --comskip-ini=/usr/local/Comskip/comskip.ini "$1" "$b"
echo "Comcut complete" 
else
echo "Comcut already done" 
endif 
break 
end

while (1)
if ( -e "$b" ) then
echo "Extracting subtitles"
ffmpeg -f lavfi -i "movie=${b}[out0+subcc]" -map 0:1 "$d"
echo "Subtitle extraction complete"
else
echo "No input file found for sub extraction"
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

HandBrakeCLI --input "$b" --output "$c" --preset-import-file /media/comchap/hb-dvr.json

rm "$b"
mv "$1" "/media/TSFiles/$a"
