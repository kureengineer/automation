#######################
# Log Sweet Script
#	This script is run every night to sync the iTunes library local to the office computer over to the DJ Computer. This is done both as a backup
#	to the office library, as well as to allow Traktor (the DJ program on the DJ computer) to play files from KURE's library without relying on a network share
#	
#	This script also exports certain playlists (the priority playlists) managed in iTunes by the Music Directors to show up in Traktor, so DJs can quickly find
#	high priority and new music.
#
#######################

#Log File
LOG="/Users/autobot/Library/Logs/Automation/log.log"

#Exclusion list file
EXC="$(dirname $0)/exc.txt"


### Icecast Logs ###
#IP address of the remote host to sync to
IP="kure-webcast.stuorg.iastate.edu"

#Source of music library files
SRC="autobot@$IP:/var/log/icecast2/"

#Destination of log files
DST="/Users/autobot/Library/Logs/Automation/Icecast/"

### Office Computer Logs ###
#IP address of the remote host to sync to
IP2="192.168.0.31"

#Source of music library files
SRC2="autobot@$IP2:/Users/autobot/Library/Logs/Automation/"

#Destination of log files
DST2="/Users/autobot/Library/Logs/Automation/Office/"


####################
##  SCRIPT START  ##
####################

#Log File Formatting
echo =============================== >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
echo Log Sweep Starting... >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$IP" >> "$LOG" 2>&1
then

#If it is,
echo "" >> "$LOG" 2>&1
echo "Connecting to $IP..." >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
#Then rsync over all the files in the iTunes library folder
# -a : archive mode
# -v : verbose mode (lists all files in the log)
# -z : compress file during data transfer
# -r : recursive into directories
# -e : indicates using a remote shell (like ssh)
# --delete : delete files at the destination if they are no longer present at the source (keeps a 1:1 sync)
# --exclude-from : ignores any files listed in the exclude text file
rsync -avzr --delete --exclude-from $EXC -e ssh "$SRC" "$DST" >> "$LOG" 2>&1

echo "" >> "$LOG" 2>&1
echo "Rsync complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1

else
echo "" >> "$LOG" 2>&1
echo "No route to host, canceling." >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
fi

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$IP2" >> "$LOG" 2>&1
then

#If it is,
echo "" >> "$LOG" 2>&1
echo "Connecting to $IP2..." >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
#Then rsync over all the files in the iTunes library folder
# -a : archive mode
# -v : verbose mode (lists all files in the log)
# -z : compress file during data transfer
# -r : recursive into directories
# -e : indicates using a remote shell (like ssh)
# --delete : delete files at the destination if they are no longer present at the source (keeps a 1:1 sync)
# --exclude-from : ignores any files listed in the exclude text file
rsync -avzr --delete --exclude-from $EXC -e ssh "$SRC2" "$DST2" >> "$LOG" 2>&1

echo "" >> "$LOG" 2>&1
echo "Rsync complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1

else
echo "" >> "$LOG" 2>&1
echo "No route to host, canceling." >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
fi



echo "Log Sweep Complete" >> "$LOG" 2>&1

#Log File Closing
echo "" >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "Complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
exit
