#!/usr/bin/liquidsoap
# Log dir
set("log.file.path","/home/autobot/webstream.log")
#set("init.daemon.pidfile.path", "<path>")

# Sources
#kureShoutCast = input.http("http://kure-automation.stuorg.iastate.edu:8000/")
kureFM = input.http("http://kure-webcast.stuorg.iastate.edu:8000/KUREBroadcast")
kureSports = input.http("http://kure-webcast.stuorg.iastate.edu:8000/KURESportscast")
kureEvents = input.http("http://kure-webcast.stuorg.iastate.edu:8000/KUREEventscast")

# Icecast Server Settings
kureHost="kure-webcast.stuorg.iastate.edu"
kurePort=8000
kureUser="********"
kurePassword="*******"

# Shoutcast recast
#output.icecast(%mp3,id="KURE Test",name="KURE Radio Broadcast",host=kureHost,port=kurePort,user="autobot",mount="KUREBroadcast",fallible=true,password=kurePassword,kureShoutCast)

# KURE FM Webcast MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="KURE MQ",name="KURE FM MQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastMQ",password=kurePassword,fallible=true,kureFM)
output.icecast(%mp3(bitrate=64),id="KURE LQ",name="KURE FM LQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastLQ",password=kurePassword,fallible=true,kureFM)

# KURE Sportscast MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="KURE Sports MQ",name="KURE Sports MQ",host=kureHost,port=kurePort,user=kureUser,mount="KURESportscastMQ",password=kurePassword,fallible=true,kureSports)
output.icecast(%mp3(bitrate=64),id="KURE Sports LQ",name="KURE Sports LQ",host=kureHost,port=kurePort,user=kureUser,mount="KURESportscastLQ",password=kurePassword,fallible=true,kureSports)

# KURE Eventcast MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="KURE Events MQ",name="KURE Sports MQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREEventscastMQ",password=kurePassword,fallible=true,kureEvents)
output.icecast(%mp3(bitrate=64),id="KURE Events LQ",name="KURE Sports LQ",host=kureHost,port=kurePort,user=kureUser,mount="KUREEventscastLQ",password=kurePassword,fallible=true,kureEvents)