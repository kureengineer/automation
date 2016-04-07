#KURE Webcast
This is the KURE Webcast server, servicing the online listening stream that appears in iTunes and on kure885.org

To access information and server administration, go to http://kure-webcast.stuorg.iastate.edu:8000

For the webcast portion, this runs Icecast, documentation and details can be found at http://icecast.org

The server additionally runs a liquidsoap script that takes the incoming high-quality stream and downgrades it to Medium and Low-quality streams. Additional information and documentation on liquidsoap can be found at http://savonet.sourceforge.net

###Functional Description
The audio source(s) for the webcast(s) are sourced from another machine, using an icecast capable application (in our case liquidsoap on Ubuntu Machines and Nicecast on OSX machines). This application takes an incoming audio stream via the computer's hardware soundcard (Alsa on Ubuntu, and CoreAudio on OSX), optionally does some processing on it, then encodes it and sends it to this server. This server's icecast program then takes this stream, and is able to serve it up on-demand to listeners that connect to it via the public url http://kure-webcast.stuorg.iastate.edu:8000. 

Icecast allows for multiple "mount" points, which essentially means multiple simultaneous webcasts. In our case, we have two main webcasts - "KURE Broadcast" and "The Basement." These two mountpoints can be sourced by either the same or two different webcast source computers.

The Icecast configuration file ```icecast.xml``` in the ```/webcast``` folder of this repository has the configuration for our purposes. Following are a few points of note for how this xml file is set up:
-Line 9, ```<clients>300</clients>``` contains the maximum number of client listeners can connect to the Icecast source **To be listed on iTunes Radio, we need a minimum of 300 capable client connections**
-Lines 96 through 120 include information for the two mounts that we use, including name and login information
-Line 114 ```<fallback-mount>/KUREBroadcast</fallback-mount>``` defines a behaviour for The Basement webcast, such that if there is no source computer providing a stream to that mount, icecast will automatiacally route client connections to The Basement webcast to the regular Broadcast. Essentially, if nothing specific is being broadcast to The Basement webcast, then the regular on-air stream is what connected clients will hear

The Liquidsoap configuration file ```webcastResample.liq``` in the ```/webcast``` folder of this repository is the script that runs on startup to downsample the webcast to medium and lower quality.

###Installation
