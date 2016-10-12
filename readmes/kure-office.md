#KURE Office
This is the Office Computer for KURE. It functions as the main computer for word processing and web browsing for almost all board needs, as well as the computer used to manage the master iTunes library that gets synced to multiple other locations within the station.

###Functional Description

#####iTunes Library Syncing

#Installation
### OS X
+ Install the latest version of OS X
+ Open System Preferences
+ In **Mouse**, deselect "Scroll Direction: Natural"
+ In **Sharing**, check "Screen Sharing," "Printer Sharing," and "Remote Login." Also change the **Computer Name** to KURE Office
+ Download UnRarX here: http://www.unrarx.com and move the app to the /Applications folder
+ Download a KURE logo image and set it to the desktop background image
+ Open up the terminal and execute the following commands to set up RSA public and private key pairs:
```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub | ssh autobot@192.168.0.1 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh autobot@192.168.0.11 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh autobot@192.168.0.22 'cat >> ~/.ssh/authorized_keys'
cat ~/.ssh/id_rsa.pub | ssh root@192.168.0.32 'cat >> ~/.ssh/authorized_keys'
```

### Dante Controller
+ Go to http://audinate.com and log in with the Engineer's credentials
+ Navigate to "Products > Dante Controller"
+ Select the matching version of OS X from the dropdown menu
+ Click the link to download the .dmg file
+ Mount the .dmg file by double clicking it in the Downloads folder
+ Double click the .pkg file and follow the on screen prompts to install Dante Controller

### XLD
+ Go to http://tmkk.undo.jp/xld/index_e.html
+ Scroll to the "Downloads" section of the page
+ Click the link to download the .dmg file
+ Mount the .dmg file by double clicking it in the Downloads folder
+ Drag the XLD app from the .dmg file into the /Applications folder
+ Drag the XLD app from the /Applications folder to the dock
+ Open a new Finder window (Command + N)
+ Open the "Go to folder" prompt (Command + Shift + G), and type in /usr/local/bin/
+ Drag the xld executable from the "CLI" folder in the .dmg into the /usr/local/bin/ window (this makes XLD available as a command line interface)
+ Open XLD from the dock
+ Under the **General** tab:
  - Select "LAME MP3" for **Output Format**
  - Click on **Option**
  - **Encoding Mode:** "CBR"
  - **Overall Quality:** "High (-q 2)"
  - **CBR (equivalent to -b n):** "320 kbps"
+ Select **Profile > Save Current Setting As...**, type "KURE," and click OK

  
### iTunes Setup
+ Open iTunes, and agree to all of the terms and conditions
+ Open up **Preferences** (Command + ,)
+ In the **General** tab:
  - Uncheck "Show Apple Music Features"
  - Check "Show Star Ratings"
  - Uncheck "Notifications when song changes"
  - Click on "Import Settings"
  - Select "Import Using: MP3 Encoder"
  - Select "Custom" for setting
  - Select "320 kbps" for "Stereo Bit Rate"
  - Click OK to both MP3 Encoder and Import Settings windows
+ In the **Sharing** tab, check "Share my library on my local network"
+ In the **Advanced** tab, check "Share iTunes Library XML with other applications"

### iTunes Export
* Go to http://www.ericdaugherty.com/dev/itunesexport/#Download
* Download the *Console Application*
* Move the downloaded folder to the /Applications folder, and rename it "iTunes Export"

### Homebrew and Git
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

