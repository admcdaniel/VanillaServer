#!/bin/bash

# Filename: stopServer.sh                                                    
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 16-Jun-2021
# Description: Shell script for starting a minecraft sever insdie of a screen session.
#              Meant to be called by systemd server deamon

screen -DmS mc bash -c "/opt/minecraft/scripts/startServer.sh"
