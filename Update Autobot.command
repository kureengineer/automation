echo =============================== >> /Applications/Automatic\ Updates/Autobot.log
echo "" >> /Applications/Automatic\ Updates/Autobot.log
echo Music Sync Starting... >> /Applications/Automatic\ Updates/Autobot.log
date >> /Applications/Automatic\ Updates/Autobot.log
echo "" >> /Applications/Automatic\ Updates/Autobot.log
cd /Applications/iTunesExport
java -mx1024m -jar itunesexport.jar -library="/Users/kureadmin/Dropbox/Library/iTunes Library.xml" -outputDir="/Volumes/Automation 3/New Automation" -includePlaylist="Autobot Low, Autobot Medium, Partybot, Groovebot, Autobot High, Autobot Light, DJoftheMonth" -fileTypes=ALL -copy=PLAYLIST >> /Applications/Automatic\ Updates/Autobot.log
cd "/Volumes/Automation 3/New Automation"
sed -i '' 's/\//\\/g' "Autobot Low.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "Autobot Medium.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "Autobot High.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "Autobot Light.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "Groovebot.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "Partybot.m3u" >> /Applications/Automatic\ Updates/Autobot.log
sed -i '' 's/\//\\/g' "DJoftheMonth.m3u" >> /Applications/Automatic\ Updates/Autobot.log

cd /Volumes/Automation\ \3/New\ \Automation
sed -i "" '1d' Autobot\ \Low.m3u
sed -i "" '1d' Autobot\ \Medium.m3u
sed -i "" '1d' Autobot\ \High.m3u
sed -i "" '1d' Groovebot.m3u
sed -i "" '1d' Partybot.m3u
sed -i "" '1d' DJoftheMonth.m3u

echo "Complete" >> /Applications/Automatic\ Updates/Autobot.log


