#!/bin/bash

#Script to update and restart the linux-utils box.


LOG="/home/autobot/restart_log.txt"
CURRENTDATE=`date`
SHUTDOWNDATE=`date -d "1 minute"`

echo "Writing to $LOG file."

echo >> $LOG
echo >> $LOG
echo "START" >> $LOG
echo >> $LOG

echo $CURRENTDATE >> $LOG

echo "Updating package list." >> $LOG
apt-get update >> $LOG

echo "Autoremoving." >> $LOG
apt autoremove -y >> $LOG

echo "Upgrading packages." >> $LOG
apt-get upgrade -y >> $LOG


echo "Scheduling shutdown for $SHUTDOWNDATE " >> $LOG
shutdown 5 -r >> $LOG
 
echo >> $LOG
echo "END" >> $LOG
echo >> $LOG
echo >> $LOG
