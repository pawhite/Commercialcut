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
logfile="/tmp/${show%.*}.log"
logofile="/tmp/${show%.*}.logo.txt"
txtfile="/tmp/${show%.*}.txt"
showfile="/tmp/${show%.*}_a.txt"
chapterfile=""
final="${infile%.*}.mkv"

i=0
start=0
hascommercials=false

writefiles()
    {
	printf "file '%s'\n" "$chapterfile" >> "$showfile"
    	duration=`echo "$end" "$start" | awk  '{printf "%f", $1 - $2}'`
    	/usr/local/bin/ffmpeg -hide_banner -loglevel error -nostdin -i "$infile" -ss $start -t $duration -c copy -y "$chapterfile"
    }


/usr/local/bin/comskip --output=/tmp --ini=/Comskip/comskip.ini "$infile"

while IFS=$'\t\n' read -r end startnext c _; 
do
  if [ `echo "$end" | awk '{printf "%i", $0 * 1000}'` -gt `echo "$start" | awk '{printf "%i", $0 * 1000}'` ]
    then
    i=$((i + 1))
    hascommercials=true
    chapterfile=/tmp/part-$i.ts
    writefiles $end $start $i "$chapterfile" "$showfile" "$infile"
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
    writefiles $end $start $i "$chapterfile" "$showfile" "$infile"
  fi
fi
    
/usr/local/bin/ffmpeg -hide_banner -loglevel error -nostdin -f concat -safe 0 -i "$showfile" -c copy -y "$outfile"

/usr/local/bin/ffmpeg -i "$outfile" -vf yadif -c:v libx264 -preset slow -crf 18 -max_muxing_queue_size 1024 -c:a copy "$final"

export LD_LIBRARY_PATH="$ldPath"
rm "$edlfile"
rm "$logfile"
rm "$logofile"
rm "$txtfile"
rm /tmp/part-*.ts
rm "$showfile"
rm "$1"
rm "$lockfile"
