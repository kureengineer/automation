#KURE Webcast
This is the KURE Webcast server, servicing the online listening stream that appears in iTunes and on kure885.org

To access information and server administration, go to http://kure-webcast.stuorg.iastate.edu:8000

For the webcast portion, this runs Icecast, documentation and details can be found at http://icecast.org

The server additionally runs a liquidsoap script that takes the incoming high-quality stream and downgrades it to Medium and Low-quality streams. Additional information and documentation on liquidsoap can be found at http://savonet.sourceforge.net

###Functional Description
The audio source(s) for the webcast(s) are sourced from another machine, using an icecast capable application (in our case liquidsoap on Ubuntu Machines and Nicecast on OSX machines). This application takes an incoming audio stream via the computer's hardware soundcard (Alsa on Ubuntu, and CoreAudio on OSX), optionally does some processing on it, then encodes it and sends it to this server. This server's icecast program then takes this stream, and is able to serve it up on-demand to listeners that connect to it via the public url http://kure-webcast.stuorg.iastate.edu:8000. 

By adding the mountpoint to the above url (http://kure-webcast.stuorg.iastate.edu:8000/KUREBroadcast), a client may connect to that particular mountpoint stream. This can be done in most modern browsers, as well as embedded in HTML5 webplayers, or other multimedia plugins.

#####Icecast
Icecast allows for multiple "mount" points, which essentially means multiple simultaneous webcasts. In our case, we have two main webcasts - "KURE Broadcast" and "The Basement." These two mountpoints can be sourced by either the same or two different webcast source computers.

The Icecast configuration file ```icecast.xml``` in the ```/webcast``` folder of this repository has the configuration for our purposes. Following are a few points of note for how this xml file is set up:

* Line 9, ```<clients>300</clients>``` contains the maximum number of client listeners can connect to the Icecast source **To be listed on iTunes Radio, we need a minimum of 300 capable client connections**
* Lines 96 through 120 include information for the two mounts that we use, including name and login information
* Line 114 ```<fallback-mount>/KUREBroadcast</fallback-mount>``` defines a behaviour for The Basement webcast, such that if there is no source computer providing a stream to that mount, icecast will automatiacally route client connections to The Basement webcast to the regular Broadcast. Essentially, if nothing specific is being broadcast to The Basement webcast, then the regular on-air stream is what connected clients will hear
* The rest of the file is pretty much the default configuration for the Icecast configuration file. It's pretty well commented, and the documentation on the Icecast website is pretty good

#####Liquidsoap
The Liquidsoap configuration file ```webcastResample.liq``` in the ```/webcast``` folder of this repository is the script that runs on startup to downsample the webcast(s) to medium and lower quality. This runs locally on the machine, and essentially "listens" to the webcasts (connects as a client), resamples the webcasts to lower mp3 bitrates (128 and 64 kbps for medium and low quality streams, respectively), and then broadcasts them as additional mountpoints on the Icecast Server, allowing listeners to select High, Medium, or Low Quality by selecting a different mountpoint to listen to.

* Lines 8 and 9 contain information for the inputs to Liquidsoap - these are client connections to the icecast server
* Lines 21 and 22 listen to the regular broadcast, re-encoding them using the ```%mp3(bitrate=192)``` tag to indicate a reencode, and then broadcast the re-encoded stream to a particular mount with the ```mount="KUREBroadcastMQ"``` tag
* Lines 25 and 26 are the same as 21 and 22, but use the ```basement``` source as an input instead of the ```kureFM``` broadcast

#####Block Diagram
```
    Broadcast Console
            |
            |
            V
    Encoding Machine Soundcard
            |
            |
            V
    OS Audio Driver (Alsa, CoreAudio, etc.)
            |
            |
            V
    Encoding Program (Liquidsoap, butt, NiceCast)
            |
            |   <----------------------------
            V                               ^
    Icecast Server Mountpoint --> Liquidsoap Down-encode Script
        |||||||||
        |||||||||
        VVVVVVVVV
    Client Connections
```
###Installation
* Start with a fresh installation of the latest version of Ubuntu Server
    * Go to http://www.ubuntu.com/download/server
    * Download the latest LTS version of server
    * Burn the ISO to a DVD using Apple OSX's disk utility or other imaging software
    * **The Poweredge we currently use won't boot from the internal drive - had to use a USB drive to boot it**
    * Boot the computer and put the DVD in
    * Restart the computer with the DVD (may have to change BIOS boot options)
    * Install while connected to the internet, following on-screen instructions
    * SSH needs to be enabled as a service, but none of the other ones are necessary

* Update and Upgrade Ubuntu Server
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
```
* Install git and download this repository
```
sudo apt-get install git
git clone https://github.com/kureengineer/automation.git 
```
* Install Icecast
```
sudo apt-get install icecast2
```
* Copy the ```icecast.xml``` from the ```webcast/``` directory of the repo to the home directory (`~/`), and change ownership to the icecast2 user
```
cp ~/automation/webcast/icecast.xml ~/
sudo chown icecast2 icecast.xml 
```
* Symlink the config file in the default location to the one in the home directory (this allows us to edit the easily findable one in the home directory instead of having to hunt for it in `/etc` all the time)
```
sudo rm -rf /etc/icecast2/icecast.xml
ln -s ~/icecast.xml /etc/icecast2/icecast.xml
```
* Add in usernames and passwords on lines 31, 33, 36, 37, 99, 100, 112, and 113 on the home directory `icecast.xml`
* Create the `start`, `stop`, and `reboot` commands in the home directory
```
ln -s ~/automation/webcast/startwebcast.sh ~/start 
ln -s ~/automation/webcast/restartwebcast.sh ~/restart
ln -s ~/automation/webcast/stop.sh ~/stop
```
* Install Liquidsoap
```
sudo apt-get install liquidsoap
```
* Copy the `webcastResample.liq` file from the `webcast/` directory of the repo to the home directory (`~/`)
```
cp ~/automation/webcast/webcastResample.liq ~/
```
* Add in username and password on lines 14 and 15 to the file in the home directory
* Edit `rc.local` to have the liquidsoap script start upon boot
```
sudo nano /etc/rc.local

On a line before "exit 0" type:
~/webcastResample.liq &
```
* Link this readme file to the home directory
```
ln -s ~/automation/readmes/kure-webcast.md ~/README
```
* Reboot the server
```
sudo reboot now
```
