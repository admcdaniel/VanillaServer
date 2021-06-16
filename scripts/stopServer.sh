#!/bin/bash

# Filename: stopServer.sh                                                    
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 16-Jun-2021
# Description: Shell script for stopping minecraft server.                                                                           

# Check if mc screen exsits
if screen -S mc -Q select . ; echo $?; then
    screen -S mc -X stuff 'stop\n'
    echo "Server Stopped"
else
    echo "echo No mc screen found. Is server running?"
fi
