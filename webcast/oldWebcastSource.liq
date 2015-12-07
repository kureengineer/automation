#!/usr/bin/liquidsoap
# Log dir
set("log.file.path","/tmp/webstream.log")
set("init.daemon.pidfile.path", "<path>")

# Source
streamInput = input.alsa(id="streamInput",bufferize=false)

# Shoutcast Server Settings
kure2Host="129.186.74.61"
kure2Port=8000
kure2User="*******"
kure2Password="******"

# Shoutcast Output Mounts
output.shoutcast(%mp3,id="webstream",name="KURE Radio HIGH Bandwidth",host=kure2Host,port=kure2Port,user=kure2User,password=kure2Password,(in()))

# Icecast Server Settings
kureHost="kure-webcast.stuorg.iastate.edu"
kurePort=8000
kureUser="******"
kurePassword="******"

# Icecast Out
output.icecast(%mp3(bitrate=320),id="KURE Test",name="KURE Radio Broadcast",host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcast",fallible=true,password=kurePassword,(in()))


#output.alsa(%mp3,id="speakerOutput",name="loopback",(input.alsa()))

#output.alsa(%mp3,id="speakers",(input.alsa():source(2,0,0)))