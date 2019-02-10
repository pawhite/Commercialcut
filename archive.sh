#!/bin/csh

/bin/mkdir -p "/media/Recorded TV/Civilizations"

/usr/bin/find /media/Recordings/ -type f -name "*Supernatural*.mkv" -exec /bin/mv {} "/media/Recorded TV/Supernatural/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Brooklyn Nine-Nine*.mkv" -exec /bin/mv {} "/media/Recorded TV/Brooklyn Nine-Nine/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Civilizations*.mkv" -exec /bin/mv {} "/media/Recorded TV/Civilizations (2018)/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Drunk History*.mkv" -exec /bin/mv {} "/media/Recorded TV/Drunk History/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Elementary*.mkv" -exec /bin/mv {} "/media/Recorded TV/Elementary/" \;
/usr/bin/find /media/Recordings/ -type f -name "*I Am the Night*.mkv" -exec /bin/mv {} "/media/Recorded TV/I Am the Night/" \;
/usr/bin/find /media/Recordings/ -type f -name "*Shakespeare Uncovered*.mkv" -exec /bin/mv {} "/media/Recorded TV/Shakespeare Uncovered/" \;
/usr/bin/find /media/Recordings/ -type f -name "*The Good Place*.mkv" -exec /bin/mv {} "/media/Recorded TV/The Good Place/" \;
/usr/bin/find /media/Recordings/ -type f -name "*The Rookie*.mkv" -exec /bin/mv {} "/media/Recorded TV/The Rookie/" \;

