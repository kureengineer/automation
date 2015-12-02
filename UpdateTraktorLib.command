#Office iTunes media folder (from the Office perspective) - ESCAPE ALL FORWARD SLASHES
OFFICE="\/Volumes\/Music\/"

#Studio iTunes media folder (from the Studio perspective) - ESCAPE ALL FORWARD SLASHES
STUDIO="\/Users\/Shared\/KURETraktor\/Music\/"



echo "" >> /Applications/Automatic\ Updates/TraktorLib.log
date >> /Applications/Automatic\ Updates/TraktorLib.log
echo "" >> /Applications/Automatic\ Updates/TraktorLib.log
echo "Starting rsync"
rsync  -arvt --delete --update --exclude .Spotlight-V100 -e ssh /Volumes/Music/ autobot@192.168.0.11:/Users/Shared/KURETraktor/Music/ >> /Applications/Automatic\ Updates/TraktorLib.log

echo "finsihed rsync"
echo "starting playlist export to /Volumes/Playlists"

cd /Applications/iTunesExport
java -mx1024m -jar itunesexport.jar -library="/Users/kureadmin/Dropbox/Library/iTunes Library.xml" -outputDir="/Volumes/Playlists" -includePlaylist="HIGH PRIORITY, DJoftheMonth" -fileTypes=ALL -



echo "Repointing the Playlist to the Studio Library location" >> /Applications/Automatic\ Updates/TraktorLib.log

#Replace the itunes root music folder with the subsonic root music folder
#Build the sed command
SEDCMD="sed -i '' 's/"
SEDCMD="$SEDCMD$OFFICE/$STUDIO/g' /Volumes/Playlists/*.m3u >> \"LOG\""
#Execute the sed command
eval "$SEDCMD"


echo "Playlist Update Complete" >> /Applications/Automatic\ Updates/TraktorLib.log


echo "Update complete" 
exit
