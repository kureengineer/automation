#Log File
LOG="$(dirname "$0")/otto.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="Autobot Low, Autobot Medium, Partybot, Groovebot, Autobot High, Autobot Light, DJoftheMonth"

#Location to save playlists
OUTPUTDIR="/Volumes/Automation 3/New Automation"

####################
##  SCRIPT START  ##
####################

#Log File Formatting
echo =============================== >> "$LOG"
echo "" >> "$LOG"
echo "Autobot Update Starting..." >> "$LOG"
date >> "$LOG"
echo "" >> "$LOG"

#Export all of the $PLAYLIST playlists, to the playlists directory on the automation machine
java -mx1024m -jar $APP -library="$LIBRARY" -outputDir="$OUTPUTDIR" -includePlaylist="$PLAYLISTS" -fileTypes=ALL -copy=PLAYLIST >> "$LOG"

#Replace forward slashes (Unix) with backslashes (windows)
sed -i '' 's/\//\\/g' "$OUTPUTDIR"*.m3u >> "$LOG"

# ????
cd /Volumes/Automation\ \3/New\ \Automation
sed -i "" '1d' Autobot\ \Low.m3u
sed -i "" '1d' Autobot\ \Medium.m3u
sed -i "" '1d' Autobot\ \High.m3u
sed -i "" '1d' Groovebot.m3u
sed -i "" '1d' Partybot.m3u
sed -i "" '1d' DJoftheMonth.m3u

#Log File Closing
echo "" >> "$LOG"
date >> "$LOG"
echo "Complete" >> "$LOG"
echo "" >> "$LOG"
exit