#######################
# NAS Library Update Script
#	This script is run every night to sync the iTunes library local to the office computer over to the Network Server. This is done both as a backup
#	to the office library, as well as access to the library via the subsonic server.
#	
#	The subsonic server exists to allow DJs to remotely log in and listen to music in KURE's library, to better plan their shows
#
#
#######################

#Log File
#LOG="$(dirname "$0")/naslibrary.log"
LOG="/Users/autobot/Library/Logs/Automation/naslibrary.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/autobot/Music/iTunes/iTunes Music Library.xml"

#Location of the itunes Export java app (http://www.ericdaugherty.com/dev/itunesexport/)
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="Autobot Low, Autobot Medium, Partybot, Groovebot, Autobot High, Autobot Light"

#Exclusion list file
EXC="$(dirname $0)/exc.txt"

#IP address of the remote host to sync to
IP="192.168.0.32"

#Source of music library files
SRC="/Users/autobot/Music/iTunes/iTunes Media/Music/"

#Destination of music library files
DST="root@$IP:/../KURE/Music/"

####################
##  SCRIPT START  ##
####################


#Log File Formatting
echo =============================== >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
echo "NAS Music Library Starting..." >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$IP" 2>&1
then
#If it is,
echo "Connecting..." >> "$LOG" 2>&1
#Then rsync over all the files in the iTunes library folder
# -a : archive mode
# -v : verbose mode (lists all files in the log)
# -z : compress file during data transfer
# -r : recursive into directories
# -e : indicates using a remote shell (like ssh)
# --delete : delete files at the destination if they are no longer present at the source (keeps a 1:1 sync)
# --exclude-from : ignores any files listed in the exclude text file
rsync -avzr --delete --exclude-from $EXC -e ssh "$SRC" "$DST" >> "$LOG" 2>&1

else
echo "No route to host, canceling." >> "$LOG" 2>&1
fi

#Log File Closing
echo "" >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "Complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
exit
