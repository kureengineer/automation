#Log File
LOG="$(dirname "$0")/autobot.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="Autobot Low, Autobot Medium, Partybot, Groovebot, Autobot High, Autobot Light, DJoftheMonth"

#Exclusion list file
EXC="$(dirname $0)/exc.txt"

#Location to save playlists
OUTPUTDIR="192.168.0.32"

SRC="/Volumes/Music/"

DST="root@192.168.0.32:/../KURE/Music/"

####################
##  SCRIPT START  ##
####################


#Log File Formatting
echo =============================== >> "$LOG"
echo "" >> "$LOG"
echo "NAS Music Library Starting..." >> "$LOG"
date >> "$LOG"
echo "" >> "$LOG"

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$OUTPUTDIR"
then
#If it is,
echo "Connecting..." >> "$LOG"
#Then rsync over all the files in the iTunes library folder
# -a : archive mode
# -v : verbose mode (lists all files in the log)
# -z : compress file during data transfer
# -r : recursive into directories
# -e : indicates using a remote shell (like ssh)
# --delete : delete files at the destination if they are no longer present at the source (keeps a 1:1 sync)
# --exclude-from : ignores any files listed in the exclude text file
rsync -avzr --delete --exclude-from $EXC -e ssh $SRC $DST >> "$LOG"

else
echo "No route to host, canceling." >> "$LOG"
fi

#Log File Closing
echo "" >> "$LOG"
date >> "$LOG"
echo "Complete" >> "$LOG"
echo "" >> "$LOG"
exit