#######################
# Traktor Library Update Script
#	This script is run every night to sync the iTunes library local to the office computer over to the DJ Computer. This is done both as a backup
#	to the office library, as well as to allow Traktor (the DJ program on the DJ computer) to play files from KURE's library without relying on a network share
#	
#	This script also exports certain playlists (the priority playlists) managed in iTunes by the Music Directors to show up in Traktor, so DJs can quickly find
#	high priority and new music.
#
#######################

#Log File
LOG="$(dirname "$0")/traktor.log"
LOG="/Users/autobot/Library/Logs/Automation/traktor.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app (http://www.ericdaugherty.com/dev/itunesexport/)
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="HIGH PRIORITY, DJoftheMonth"

#Exclusion list file
EXC="$(dirname $0)/exc.txt"

#IP address of the remote host to sync to
IP="192.168.0.11"

#Source of music library files
SRC="/Volumes/Music/"

#Destination of music library files
DST="autobot@$IP:/Users/Shared/KURETraktor/Music/"

#Location to save playlists
OUTPUTDIR="/Volumes/Playlists"

#Office iTunes media folder (from the Office perspective) - ESCAPE ALL FORWARD SLASHES
OFFICE="\/Volumes\/Music\/"

#Studio iTunes media folder (from the Studio perspective) - ESCAPE ALL FORWARD SLASHES
STUDIO="\/Users\/Shared\/KURETraktor\/Music\/"


####################
##  SCRIPT START  ##
####################

#Log File Formatting
echo =============================== >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
echo Traktor Update Starting... >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$IP"
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
rsync -avzr --delete --exclude-from $EXC -e ssh $SRC $DST >> "$LOG" 2>&1
echo "Rsync complete" >> "$LOG" 2>&1

else
echo "No route to host, canceling." >> "$LOG" 2>&1
fi


#Export all of the $PLAYLIST playlists, to the playlists directory on the automation machine
echo "starting playlist export to /Volumes/Playlists" >> "$LOG" 2>&1
java -mx1024m -jar $APP -library="$LIBRARY" -outputDir="$OUTPUTDIR" -includePlaylist="$PLAYLISTS" -fileTypes=ALL >> "$LOG" 2>&1



echo "Repointing the Playlist to the Studio Library location" >> "$LOG" 2>&1

#Replace the itunes root music folder with the subsonic root music folder
#Build the sed command
SEDCMD="sed -i '' 's/"
SEDCMD="$SEDCMD$OFFICE/$STUDIO/g' $OUTPUTDIR/*.m3u >> \"LOG\""
#Execute the sed command
eval "$SEDCMD" >> "$LOG" 2>&1

echo "Playlist Update Complete" >> "$LOG" 2>&1

#Log File Closing
echo "" >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "Complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
exit
