echo =============================== >> /Applications/Automatic\ Updates/NAS\ Update.log
echo "" >> /Applications/Automatic\ Updates/NAS\ Update.log
echo Music Sync Starting... >> /Applications/Automatic\ Updates/NAS\ Update.log
date >> /Applications/Automatic\ Updates/NAS\ Update.log
echo "" >> /Applications/Automatic\ Updates/NAS\ Update.log
if
/sbin/ping -o -c 3 -t 1 192.168.0.32
then
echo "Connecting..." >> /Applications/Automatic\ Updates/NAS\ Update.log
rsync -avzr --delete --exclude .Trashes -e ssh /Volumes/Music/ root@192.168.0.32:/../KURE/Music/ >> /Applications/Automatic\ Updates/NAS\ Update.log
echo "Complete" >> /Applications/Automatic\ Updates/NAS\ Update.log
else
echo "No route to host, canceling." >> /Applications/Automatic\ Updates/NAS\ Update.log
fi
echo "" >> /Applications/Automatic\ Updates/NAS\ Update.log
exit