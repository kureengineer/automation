#!/usr/bin/liquidsoap
# Log dir
set("log.file.path","/home/autobot/webstream.log")
#set("init.daemon.pidfile.path", "<path>")

# Sources
#kureShoutCast = input.http("http://kure-automation.stuorg.iastate.edu:8000/")
kureFM = input.http("http://kure-webcast.stuorg.iastate.edu:8000/KUREBroadcast")
basement = input.http("http://kure-webcast.stuorg.iastate.edu:8000/TheBasement")

# Icecast Server Settings
kureHost="kure-webcast.stuorg.iastate.edu"
kurePort=8000
kureUser="********"
kurePassword="*******"

# Shoutcast recast
# output.icecast(%mp3,id="KURE Test",name="KURE Radio Broadcast",host=kureHost,port=kurePort,user="autobot",mount="KUREBroadcast",fallible=true,password=kurePassword,kureShoutCast)

# KURE FM Webcast MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="KURE MQ",name="KURE FM MQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastMQ",password=kurePassword,fallible=true,kureFM)
output.icecast(%mp3(bitrate=64),id="KURE LQ",name="KURE FM LQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastLQ",password=kurePassword,fallible=true,kureFM)

# The Basement MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="The Basement MQ",name="The Basement MQ",host=kureHost,port=kurePort,user=kureUser,mount="TheBasementMQ",password=kurePassword,fallible=true,basement)
output.icecast(%mp3(bitrate=64),id="The Basement LQ",name="The Basement LQ",host=kureHost,port=kurePort,user=kureUser,mount="TheBasementLQ",password=kurePassword,fallible=true,basement)
