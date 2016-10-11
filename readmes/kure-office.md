#KURE Office
This is the Office Computer for KURE. It functions as the main computer for word processing and web browsing for almost all board needs, as well as the computer used to manage the master iTunes library that gets synced to multiple other locations within the station.

###Functional Description

#####iTunes Library Syncing

#Installation
### General Items
* Install Dante Controller
  + Go to http://audinate.com and log in with the Engineer's credentials
  + Navigate to "Products > Dante Controller"
  + Select the matching version of OS X from the dropdown menu
  + Click the link to download the .dmg file
  + Mount the .dmg file by double clicking it in the Downloads folder
  + Double click the .pkg file and follow the on screen prompts to install Dante Controller
* Install Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install git and download this repository
```
brew install git
git clone https://github.com/kureengineer/automation.git ~/Documents/Automation
```

### Autobot/Traktor/Subsonic Sync Script
* Install and configure the airchecks recording script
  + Copy the airchecks script to a working location, and make it executable
```
cp ~/Documents/Automation/airchecks.sh ~/Documents/airchecks.sh
sudo chmod +x ~/Documents/airchecks.sh
```
   + Open up the airchecks script and fill in specific data:
    - **Line 12**: The location to write the log to
    - **Line 22**: The directory that a recording is temporarily stored to while it is being recorded
    - **Line 25**: The directory in which to place all recordings once they are completed
   + Schedule the airchecks script to start 5 minutes before the start of the hour:
```
crontab -e
```
   + Type **i** to enter insert mode, and type the following two lines into the crontab:
```
PATH = /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
55      *       *       *       *       /bin/sh /Users/autobot/Documents/Automation/aircheck.sh
```
   + Type **escape**, then **:wq**, then **enter**

