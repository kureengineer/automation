#######################
# Aircheck Recording  Script
#	This script is meant to be scheduled every so often (through a cron job) to record the broadcast, for airchecks purposes.
#
#	This requires sox, so be sure homebrew is installed (http://brew.sh/), and sox is installed through it (sudo brew install sox).
#	
#	The script automatically names the file based on year, month, day, and time, transcodes it to an mp3, and moves it to a specified directory
#
#######################

#File type
FILETYPE='mp3'

#The filename to record to, formatted as "YYYYMMDD HHMMPM Aircheck.mp3"
FILENAME=$(date '+20%y%m%d %I%M%p Aircheck.')
FILENAME="$FILENAME$FILETYPE"

#The output directory to record to **Keep this as a local drive, not a network drive**
RECDIR='/Users/dnhushak/Documents/'

#Directory to move the recorded files to
OUTDIR="/Users/dnhushak/Desktop/Airchecks/$(date '+20%y%m%d')/"

#The duration of the recording (in hh:mm:ss format, or simply a numeric seconds format)
DURATION='1'

####################
##  SCRIPT START  ##
####################

#Generate output file, with the directory
OUTFILE="$RECDIR$FILENAME"

#Record the file to the output directory and file, based on the duration
# -d : use the default sound device for an input stream
# trim : trim the "file" (in this case a stream) from a starting point to an end point
sox -d "$OUTFILE" trim 0 $DURATION 

#Check if the desired output directory exists...
if [[ ! -d "$OUTDIR" ]]; then
	#If it doesn't, make the directory
	mkdir "$OUTDIR"
fi

#And move all of the files to said directory
mv -f "$RECDIR*.$FILETYPE" "$OUTDIR"