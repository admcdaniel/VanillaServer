#!/bin/bash

# Filename: worldBackup.sh                                                    
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 09-Aug-2021
# Description: Shell script for backing up vanilla Minecraft worlds, and 
#               removing backups older than 7 days.                                                                           


# Check if mc screen exsits
if screen -S mc -Q select . ; echo $?; then

    # Create world backup directory if it doesn't exist
    mkdir -p /var/minecraft/backups/$worldName

    # Turn off auto-save, and broadcast backup running
    screen -S mc -p 0 -X stuff "save-off\nsay Server Saving Disabled. Running Backup.\n"

    # Get the date and the current world name    
    d=$(date +%Y-%m-%d)
    worldName=$(cat /opt/minecraft/server/server.properties | grep level-name= | sed 's/.*\=//')

    # Backup world into tarbar
    tar -cpvzf /var/minecraft/backups/$worldName/$worldName-$d.tar.gz /opt/minecraft/server/$worldName
    
    # Turn on auto save, and broadcast server restart
    screen -S mc -p 0 -X stuff "save-on\nsay Serving Saving Enabled. Backup Complete! Restarting Server...\n"
    sleep 5
    /opt/minecraft/scripts/restartServer.sh

    # Delete backups untill only the last 7 days of backups remain 
    if cd /var/minecraft/backups/$worldName/; then
        while [ $(ls | wc -l) -gt 7 ]; do
        rm -fr "$(ls -t /var/minecraft/backups/$worldName/ | tail -1)"
        done
    fi
    
else
    echo "No mc screen found. Is server running?"

fi

