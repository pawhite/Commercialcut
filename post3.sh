#!/bin/sh

PATH=$PATH:/usr/local/bin:/usr/bin

#LD_LIBRARY_PATH is set and will mess up ffmpeg, unset it, then re-set it when done
ldPath=${LD_LIBRARY_PATH}
unset LD_LIBRARY_PATH

lockfile="/tmp/post.lock"
while [ -f "$lockfile" ]; do
    echo "Waiting"
    sleep 5
done

touch "$lockfile"

infile=$1
outfile="$infile"
show=`basename "$infile"`
edlfile="/tmp/${show%.*}.edl"
metafile="/tmp/${show%.*}.ffmeta"
logfile="/tmp/${show%.*}.log"
logofile="/tmp/${show%.*}.logo.txt"
txtfile="/tmp/${show%.*}.txt"
showfile="/tmp/${show%.*}_a.txt"
chapterfile=""
a="${infile%.*}.mkv"

i=0
start=0
hascommercials=false
totalcutduration=0

writefiles()
    {
	echo [CHAPTER] >> "$metafile"
    	echo TIMEBASE=1/1000 >> "$metafile"
    	echo START=`echo "$start  $totalcutduration" | awk  '{printf "%i", ($1 - $2) * 1000}'` >> "$metafile"
    	echo END=`echo "$end $totalcutduration" | awk  '{printf "%i", ($1 - $2) * 1000}'` >> "$metafile"
    	echo "title=Chapter $i" >> "$metafile"
        printf "file '%s'\n" "$chapterfile" >> "$showfile"
    	duration=`echo "$end" "$start" | awk  '{printf "%f", $1 - $2}'`
    	/usr/local/bin/ffmpeg -hide_banner -loglevel error -nostdin -i "$infile" -ss $start -t $duration -c copy -y "$chapterfile"
    }


/usr/local/bin/comskip --output=/tmp --ini=/Comskip/comskip.ini "$infile"

echo ";FFMETADATA1" > "$metafile"
# Reads in from $edlfile, see end of loop.
while IFS=$'\t\n' read -r end startnext c _; 
do
  if [ `echo "$end" | awk '{printf "%i", $0 * 1000}'` -gt `echo "$start" | awk '{printf "%i", $0 * 1000}'` ]
    then
    i=$((i + 1))
    hascommercials=true
    chapterfile=/tmp/part-$i.ts
    writefiles $end $start $totalcutduration $i "$metafile" "$chapterfile" "$showfile"
    totalcutduration=`echo "$totalcutduration" "$startnext" "$end" | awk  '{print $1 + $2 - $3}'`
  fi
  start=$startnext
done < "$edlfile"

#dont forget to add the final part from last commercial to end of file
if [ $hascommercials=true ]
  then
  end=`/usr/local/bin/ffmpeg -hide_banner -nostdin -i "$infile" 2>&1 | grep Duration | awk '{print $2}' | tr -d , | awk -F: '{ printf "%f", ($1*3600)+($2*60)+$3 }'`
  if [ `echo "$end" | awk '{printf "%i", $0 * 1000}'` -gt `echo "$start" | awk '{printf "%i", $0 * 1000}'` ]
    then
    i=$((i + 1))
    chapterfile=/tmp/part-$i.ts
    writefiles $end $start $totalcutduration $i "$metafile" "$chapterfile" "$showfile"
  fi
fi
    
/usr/local/bin/ffmpeg -hide_banner -loglevel error -nostdin -f concat -safe 0 -i "$showfile" -c copy -y "$outfile"

/usr/local/bin/ffmpeg -i "$outfile" -vf yadif -c:v libx264 -preset slow -crf 18 -max_muxing_queue_size 1024 -c:a copy "$a"

export LD_LIBRARY_PATH="$ldPath"
rm "$edlfile"
rm "$metafile"
rm "$logfile"
rm "$logofile"
rm "$txtfile"
rm /tmp/part-*.ts
rm "$showfile"
rm "$lockfile"
