#!/usr/bin/liquidsoap
# Log dir
set("log.file.path","/home/autobot/webstream.log")
#set("init.daemon.pidfile.path", "<path>")

# Sources
kureFM = input.http("http://kure-webcast.stuorg.iastate.edu:8000/KUREBroadcast")
basement = input.http("http://kure-webcast.stuorg.iastate.edu:8000/TheBasement")

# Stream Parameters
description = "KURE is a volunteer student run radio station servicing alternative music, news, and cyclone sports to Iowa State University and the Ames Community."
url = "http://www.kure885.org"
genre = "Indie"

# Icecast Server Settings
kureHost="kure-webcast.stuorg.iastate.edu"
kurePort=8000
kureUser="********"
kurePassword="********"

# KURE FM Webcast MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="KURE MQ",name="88.5 KURE Medium Quality",url=url,genre=genre,description=description,host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastMQ",password=kurePassword,fallible=true,kureFM)
output.icecast(%mp3(bitrate=64),id="KURE LQ",name="88.5 KURE Low Quality",url=url,genre=genre,description=description,host=kureHost,port=kurePort,user=kureUser,mount="KUREBroadcastLQ",password=kurePassword,fallible=true,kureFM)

# The Basement MQ/LQ Stream Re-encodes
output.icecast(%mp3(bitrate=192),id="The Basement MQ",name="The Basement MQ",url=url,genre=genre,description=description,host=kureHost,port=kurePort,user=kureUser,mount="TheBasementMQ",password=kurePassword,fallible=true,basement)
output.icecast(%mp3(bitrate=64),id="The Basement LQ",name="The Basement LQ",url=url,genre=genre,description=description,host=kureHost,port=kurePort,user=kureUser,mount="TheBasementLQ",password=kurePassword,fallible=true,basement)

