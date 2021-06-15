#!/bin/bash

# Filename: worldBackup.sh                                                    
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 15-Jun-2021
# Description: Shell script for backing up vanilla Minecraft worlds, and 
#               removing backups older than 7 days.                                                                           


# Check if mc screen exsits
if screen -S mc -Q select . ; echo $?; then

    # Turn off auto-save, and broadcast backup running
    screen -S mc -p 0 -X stuff "save-off\nsay Server Saving Disabled. Running Backup.\n"
    
    # Backup world into tarbar
    d=$(date +%Y-%m-%d)
    tar -cpvzf /opt/minecraft/Backups/TLHF2/TLHF2-$d.tar.gz /opt/minecraft/TLHF2
    
    # Turn on auto save, and broadcast server restart
    screen -S mc -p 0 -X stuff "save-on\nsay Serving Saving Enabled. Backup Complete! Restarting Server...\n"
    sleep 5
    /opt/minecraft/scripts/restartServer.sh
    
    if cd /opt/minecraft/Backups/TLHF2/; then
        rm -fr "$(ls -t /opt/minecraft/Backups/TLHF2/ | tail -1)"
    fi
    
else
    echo "No mc screen found. Is server running?"

fi

