#!/bin/bash

# Filename: stopServer.sh                                                    
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 16-Jun-2021
# Description: Shell script for starting minecraft server
 
cd /opt/minecraft/server
java -Xms5G -Xmx5G -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch -XX:+UseLargePages -XX:+UseLargePagesInMetaspace -XX:LargePageSizeInBytes=2m -jar server.jar nogui
