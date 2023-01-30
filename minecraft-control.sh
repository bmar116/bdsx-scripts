#!/usr/bin/bash

cd /srv/minecraft

# On first run, make sure screen is running
if ! screen -list | grep -q MinecraftServer; then
	screen -S MinecraftServer ./bdsx-scripts/start.sh
fi

# Send argument $1 to screen with trailing newline
function sendtoserver () {
	screen -S MinecraftServer -X stuff "$1"$'\n'
}

# Backup server world
function backup () {
	sendtoserver "say Backing up world..."
	sendtoserver "save hold"
	sleep 5
	CURRENTDATE=`date +"%Y%m%d-%H%M%S"`
	tar -cf worlds/backup/Bedrock_level-${CURRENTDATE}.tar worlds/Bedrock\ level/
	sendtoserver "save resume"
	sendtoserver "say Backup complete!"
}

# Clear out backups folder
# Remove backups more than 14 days old
function cleanbackups () {
	find ./worlds/backup -type f -mtime +13 -delete
}

# If logging in, attach to screen
if [ "$1" == "login" ]; then
	screen -Dr MinecraftServer
fi

# Send stop command; server will automatically restart in 5 seconds
if [ "$1" == "stop" ]; then
	screen -S MinecraftServer -X stuff "stop"$'\n'
fi

# Backup world
# Announce backup, hold, wait, tar, resume
if [ "$1" == "backup" ]; then
	backup
	if [ "$2" == "clean" ]; then
		cleanbackups
	fi
	
fi

# Auto restart
# backs up the world then stops the server
if [ "$1" == "restart" ]; then
	backup
	sendtoserver "say Server will restart in 5 seconds..."
	sleep 5
	sendtoserver "stop"
fi
