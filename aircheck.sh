#######################
# Aircheck Recording  Script
#	This script is meant to be scheduled every so often (through a cron job) to record the broadcast, for airchecks purposes.
#
#	This requires sox, so be sure homebrew is installed (http://brew.sh/), and sox is installed through it (sudo brew install sox).
#	
#	The script automatically names the file based on year, month, day, and time, transcodes it to an mp3, and moves it to a specified directory
#
#######################

#Log File
LOG="$(dirname "$0")/aircheck.log"

#File type to record to
FILETYPE='mp3'

#The filename to record to, formatted as "YYYYMMDD HHMMPM Aircheck.mp3"
FILENAME=$(date '+20%y%m%d %I%M%p Aircheck.')
FILENAME="$FILENAME$FILETYPE"

#The output directory to record to **Keep this as a local drive, not a network drive**
RECDIR='/Users/dnhushak/Documents/'

#Directory to move the recorded files to, presumably a shared drive
OUTDIR="/Users/dnhushak/Desktop/Airchecks/"
#Separates the airchecks into folders by days
OUTDIR="$OUTDIR$(date '+20%y%m%d')/"

#The duration of the recording (in hh:mm:ss format, or simply a numeric seconds format)
DURATION='1:00'

####################
##  SCRIPT START  ##
####################

#Log File Formatting
echo =============================== >> "$LOG"
echo "" >> "$LOG"
echo "Aircheck Recording Starting..." >> "$LOG"
date >> "$LOG"
echo "" >> "$LOG"

#Generate output file, with the directory
OUTFILE="$RECDIR$FILENAME"

echo "Recording to $OUTFILE" >> "$LOG"

#Record the file to the output directory and file, based on the duration
# -d : use the default sound device for an input stream
# trim : trim the "file" (in this case a stream) from a starting point to an end point
sox -d "$OUTFILE" trim 0 $DURATION 2>>"$LOG"

#Creates a spectrogram image of the file
sox "$OUTFILE" -n spectrogram -o "$OUTFILE.png" 2>>"$LOG"

#Check if the desired output directory exists...
if [[ ! -d "$OUTDIR" ]]; then
	echo "Creating date directory $OUTDIR" >> "$LOG"
	#If it doesn't, make the directory
	mkdir "$OUTDIR" >> "$LOG"
fi


#And move all of the files to said directory
echo "Moving files" >> "$LOG"
mv -f "$RECDIR$FILENAME" "$OUTDIR" >> "$LOG"
mv -f "$RECDIR$FILENAME.png" "$OUTDIR" >> "$LOG"

#Log File Closing
echo "" >> "$LOG"
date >> "$LOG"
echo "Complete" >> "$LOG"
echo "" >> "$LOG"
exit