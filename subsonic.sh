#Log File
LOG="$(dirname "$0")/subsonic.log"

#Location of iTunes Library on Office Computer
LIBRARY="/Users/kureadmin/Dropbox/Library/iTunes Library.xml"

#Location of the itunes Export java app (http://www.ericdaugherty.com/dev/itunesexport/)
APP="/Applications/iTunesExport/itunesexport.jar"

#Playlists to Export, separated by commas
PLAYLISTS="Subsonic High, Partybot"

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
echo =============================== >> "$LOG"
echo "" >> "$LOG"
echo Subsonic Update Starting... >> "$LOG"
date >> "$LOG"
echo "" >> "$LOG"


#Export all of the $PLAYLIST playlists, to the automatic updates directory
java -mx1024m -jar $APP -library="$LIBRARY" -outputDir="$OUTPUTDIR" -includePlaylist="$PLAYLISTS" -fileTypes=ALL  >> "$LOG"


#Replace the itunes root music folder with the subsonic root music folder
#Build the sed command
SEDCMD="sed -i '' 's/"
SEDCMD="$SEDCMD$ITUNES/$SUBSONIC/g' \"$OUTPUTDIR\"*.m3u >> \"LOG\""
#Execute the sed command
eval "$SEDCMD"

#Replace forward slashes (Unix) with backslashes (windows)
sed -i '' 's/\//\\/g' "$OUTPUTDIR"*.m3u >> "$LOG"

#NEED TO ADD CURL COMMAND TO SEND PLAYLIST TO SUBSONIC


#Log File Closing
echo "" >> "$LOG"
date >> "$LOG"
echo "Complete" >> "$LOG"
echo "" >> "$LOG"
exit