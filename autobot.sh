#######################
# Autobot Update Script
#	This script is run every night to update the Autobot automation computer playlists. These playlists are managed in iTunes, and exported straight to the Autobot computer
#	to a location that the Automation software (RadioBoss) can read from.
#	The script parses through the iTunes library, selects the given playlists, and expors those playlists to m3u files. It also changes the file references in the m3u files
#	to match the file structure of the Automation Computer
#	In addition to the m3u playlists, the script also copies the referenced files over, and separates the files into folders based on playlists.
#	So if songs A, B, and C are on playlist 1, and C, D, and E are on playlist 2, two folders will be created: 1, with files A, B, and C in it; and 2, with files C, D, and E
#######################

#Log File
LOG="$(dirname "$0")/otto.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app (http://www.ericdaugherty.com/dev/itunesexport/)
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
# -copy=PLAYLIST copies over the files in addition to the playlists, and organizes them into folders based on the playlists
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