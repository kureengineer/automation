#Office iTunes media folder (from the Office perspective) - ESCAPE ALL FORWARD SLASHES
OFFICE="\/Volumes\/Music\/"

#Studio iTunes media folder (from the Studio perspective) - ESCAPE ALL FORWARD SLASHES
STUDIO="\/Users\/Shared\/KURETraktor\/Music\/"

#Log File
LOG="$(dirname "$0")/autobot.log"

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

####################
##  SCRIPT START  ##
####################


echo "" >> /Applications/Automatic\ Updates/TraktorLib.log
date >> /Applications/Automatic\ Updates/TraktorLib.log
echo "" >> /Applications/Automatic\ Updates/TraktorLib.log

#Check to make sure NAS is active on the network
if
/sbin/ping -o -c 3 -t 1 "$IP"
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
echo "Rsync complete" >> "$LOG"

else
echo "No route to host, canceling." >> "$LOG"
fi


#Export all of the $PLAYLIST playlists, to the playlists directory on the automation machine
echo "starting playlist export to /Volumes/Playlists" >> "$LOG"
java -mx1024m -jar $APP -library="$LIBRARY" -outputDir="$OUTPUTDIR" -includePlaylist="$PLAYLISTS" -fileTypes=ALL >> "$LOG"



echo "Repointing the Playlist to the Studio Library location" >> "$LOG"

#Replace the itunes root music folder with the subsonic root music folder
#Build the sed command
SEDCMD="sed -i '' 's/"
SEDCMD="$SEDCMD$OFFICE/$STUDIO/g' $OUTPUTDIR/*.m3u >> \"LOG\""
#Execute the sed command
eval "$SEDCMD" >> "$LOG"

echo "Playlist Update Complete" >> "$LOG"


#Log File Closing
echo "" >> "$LOG"
date >> "$LOG"
echo "Complete" >> "$LOG"
echo "" >> "$LOG"
exit
