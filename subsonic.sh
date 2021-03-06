#######################
# Subsonic Playlist Update Script
#	This script is run every night to update the Subsonic server playlists. The Subsonic server exists to allow DJs to see and listen to new music.
#
#	The script parses through the iTunes library, selects the given playlists, and expors those playlists to m3u files. It also changes the file references in the m3u files
#	to match the file structure of the Subsonic Computer.
#	As of right now, there is no way to automatically import the m3u playlist into subsonic, so it must be done manually (presumably by the Internal Music Director once a week)
#
#######################

#Log File
#LOG="$(dirname "$0")/subsonic.log"
LOG="/Users/autobot/Library/Logs/Automation/subsonic.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app (http://www.ericdaugherty.com/dev/itunesexport/)
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="Subsonic High"

#Location to save playlists
OUTPUTDIR="$(dirname "$0")/Subsonic/"

#iTunes media folder (from the iTunes perspective) - ESCAPE ALL FORWARD SLASHES
ITUNES="\/Volumes\/Music\/"

#Subsonic media folder (from the Subsonic perspective) - DOUBLE ESCAPE CHARACTERS, so a single backslash will need to be escaped (\\), and then both of those need to be escaped (\\\\)
SUBSONIC="\\\\\\\\kure-library\\\\KURE\\\\Music\\\\"

####################
##  SCRIPT START  ##
####################

#Log File Formatting
echo =============================== >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
echo Subsonic Update Starting... >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1


#Export all of the $PLAYLIST playlists, to the automatic updates directory
java -mx1024m -jar $APP -library="$LIBRARY" -outputDir="$OUTPUTDIR" -includePlaylist="$PLAYLISTS" -fileTypes=ALL  >> "$LOG" 2>&1


#Replace the itunes root music folder with the subsonic root music folder
#Build the sed command
SEDCMD="sed -i '' 's/"
SEDCMD="$SEDCMD$ITUNES/$SUBSONIC/g' \"$OUTPUTDIR\"*.m3u >> \"LOG\""
#Execute the sed command
eval "$SEDCMD" 2>&1

#Replace forward slashes (Unix) with backslashes (windows)
sed -i '' 's/\//\\/g' "$OUTPUTDIR"*.m3u >> "$LOG" 2>&1

#NEED TO ADD CURL COMMAND TO SEND PLAYLIST TO SUBSONIC


#Log File Closing
echo "" >> "$LOG" 2>&1
date >> "$LOG" 2>&1
echo "Complete" >> "$LOG" 2>&1
echo "" >> "$LOG" 2>&1
exit
