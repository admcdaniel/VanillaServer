#!/usr/bin/python3

# Filename: RetrieveServer.py                                                  
# Language: Python
# Author: amcdaniel <austinmcdaniel70@gmail.com>
# Last Modified: 17-Jun-2021
# Description: Retreive latest vanilla Minecraft server jar from url

import urllib.request, json, requests

# Get URL to lastest version JSON
with urllib.request.urlopen("https://launchermeta.mojang.com/mc/game/version_manifest.json") as url:
    data = json.loads(url.read().decode())
    server_json_url = data['versions'][0]['url']

# Get download URL from lastest release JSON
with urllib.request.urlopen(server_json_url) as server_url:
    data = json.loads(server_url.read().decode())
    server_jar_url = data['downloads']['server']['url']
    
# Download jar and write to file
server_jar = requests.get(server_jar_url, allow_redirects=True)
open('/opt/minecraft/server/server.jar', 'wb').write(server_jar.content)
