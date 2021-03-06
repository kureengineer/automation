#KURE Server
This is the KURE OSX server, servicing a number of functions for the station, including (but not limited to) DHCP, VPN, Webcast Sourcing, a Subsonic Server, and Airchecks Recording.

DHCP, VPN, and VNC are all managed through OSX Server, documentation and details for which can be found at https://support.apple.com/macos/server.

To access information and server administration, you must connect to the KURE VPN and either SSH or VNC into the server at the address ```192.168.0.1```.

For the subsonic server, documentation and details can be found at http://subsonic.org.

The webcast source uses an OSX native application called Nicecast. Documentation and details can be found at https://www.rogueamoeba.com/nicecast/.

###Functional Description


#####DHCP
The XServe serves as a DHCP server for the KURE intranet. It assigns IP addresses in the subnet ```192.168.0.xxx```. There is a set of static IP addresses, for station networked audio equipment and computers that are always on and need to be regularly accessible.

Additional "ad hoc" connections are assigned to a non-static IP pool in the same subnet, with addresses ranging from ```100-200```. All VPN connections are assigned addresses ```50-99```.

#####VPN
OSX Server provides VPN services, which allows any client with internet access to be able to access the secured internal KURE network from anywhere.

#####Dante Virtual Soundcard

#####Webcast Sourcing

#####Airchecks Recording

#Installation
### Automation Repository
* Install Homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install git and download this repository
```
brew install git
git clone https://github.com/kureengineer/automation.git ~/Documents/Automation
```

### Airchecks Script
* Install SoX
```
brew install sox
```
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

### Nicecast
  * Go to https://www.rogueamoeba.com/nicecast/download.php
  * Unzip the file and place the unzipped Nicecast application in the OSX ```/Applications``` folder
  * Open Nicecast, and select **Nicecast > License** from the menu
  * Enter the user and KURE license key (as listed in the "KURE Technical Documentation" spreadsheet) to license Nicecast
  * Open up preferences, either by selecting **Nicecast > Preferences** from the menu, or by typing **Command + ,**
  * Be sure **Start Broadcast at Launch** and **Check Automatically** are **checked**
  * Be sure **Display Listener Badge,** and **Animated** are **unchecked**
  * Set up Audio Settings
     + In the main Nicecast Window, select the **Source** tab
     + In the first dropdown, select "*Audio Device*"
     + In the **Select** dropdown, select **Dante Virtual Soundcard**
     + Click on the "Advanced" button
     + Under **Input Device Settings**, select **3** and **4** for **Left Channel** and **Right Channel**, respectively
     + Click on the **Quality** tab
     + Select **320 kbps** for **Bitrate**
     + Select **44.100 Khz** for **Sample Rate**
     + Select **Stereo** for **Channels**
     + Leave the **CPU Usage** slider at its default value
  * Set up Metadata
     + Select the **Info** tab
     + Fill in the following information in the fields:
       - Name: **88.5 KURE Ames Alternative**
       - URL: **http://kure885.org**
       - Genre: **College**
       - AIM: **kuredj**
       - Description: **KURE is a volunteer student run radio station servicing alternative music, news, and cyclone sports to Iowa State University and the Ames Community.**
     + Select the **Titles** tab
     + Make sure **Artist**, **Album**, and **Title** are all **checked**
  * Set up server connection settings
     + Open up server settings, either by selecting **Window > Show Server** or typing **Command + 2**
     + Make sure the list of servers tab is open - if it is not, click on the tab icon on the top right of the server window
     + Fill in the following information in the fields:
       - Name: **KURE Broadcast**
       - Server Type: **Icecast 2**
       - Account: Whatever your account is for your icecast server mount
       - Password: Whatever your password is for your icecast server mount
       - Address: ```kure-webcast.stuorg.iastate.edu```
       - Port: **8000**
       - Mount Point: **/KUREBroadcast** - note the leading slash
       - Public URL: Leave as **Automatic**
     + In the **Servers** drawer, be sure the new one you just created is selected 
     + ![Server Settings](https://github.com/kureengineer/automation/blob/master/readmes/images/serversettings.png?raw=true "Nicecast Server Settings")
  * Click **Start Broadcast** and let it roll
  * Right click on the Nicecast Icon in the dock, and under **Options**, select **Keep in Dock** and **Open at Login**

