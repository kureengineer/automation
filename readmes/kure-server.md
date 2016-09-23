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


###Installation
* Install homebrew
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install git and download this repository
```
brew install git
git clone https://github.com/kureengineer/automation.git 
```
* Install and configure Nicecast
** Go to https://www.rogueamoeba.com/nicecast/download.php
** Unzip the file and place the unzipped Nicecast Applications in the OSX ```/Applications``` folder
** Open Nicecast, and select "Nicecast > License" from the menu
** Enter the user and KURE license key (as listed in the "KURE Technical Documentation" spreadsheet) to license Nicecast
** Open up preferences, either by selecting "Nicecast > Preferences" from the menu, or by typing "Command + ,"
** Be sure "Start Broadcast at Launch" and "Check Automatically" are *checked*
** Be sure "Display Listener Badge," and "Animated" are *unchecked*
