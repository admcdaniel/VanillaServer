#!/bin/bash

# Filename: initalizeServer.sh                                                  
# Language: Bash
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 09-Aug-2021
# Description: First time setup script for VanillaMCServer


# Retrieve latest server JAR
python3 /opt/minecraft/scripts/RetrieveServer.py

# Create Server Daemon
useradd -r mc

# Assign permissions
chown -R mc:mc /opt/minecraft
chmod 700 /opt/minecraft

# Run Server once to generate EULA
systemctl start VanillaMCServer
sleep 5
systemctl stop VanillaMCServer

# Accept EULA
sed -i 's/eula=false/eula=true/g' /opt/minecraft/server/eula.txt 
