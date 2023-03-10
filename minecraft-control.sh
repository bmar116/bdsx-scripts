#!/usr/bin/bash

cd /srv/minecraft

# Return if screen is running
if [ "$1" == "running" ]; then
	if screen -list | grep -q "MinecraftServer"; then
		echo "MinecraftServer is running."
	else
		echo "MinecraftServer is not running."
	fi
	
	exit 0
fi

# Start screen & server if not already running
if ! screen -list | grep -q MinecraftServer; then
	screen -L -Logfile ./bdsx/logs/latest.log -S MinecraftServer bash ./bdsx-scripts/start.sh
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
	if [ ! -d "./backup" ]; then
		mkdir backup
	fi
	cd bedrock_server
	tar -cf ../backup/worlds-${CURRENTDATE}.tar worlds/
	cd ..
	sendtoserver "save resume"
	sendtoserver "say Backup complete!"
}

# Clear out backups folder
# Remove backups more than 14 days old
function cleanbackups () {
	find ./backup/worlds -type f -mtime +13 -delete
}

# If logging in, attach to screen
if [ "$1" == "login" ]; then
	screen -Dr MinecraftServer
fi

# Send stop command; server will automatically restart in 5 seconds
if [ "$1" == "stop" ]; then
	sendtoserver "say Server will stop in 5 seconds..."
	sleep 5
	sendtoserver "stop"
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
	if [ "$2" == "backup" ]; then
		backup
		if [ "$3" == "clean" ]; then cleanbackups; fi
	fi
	sendtoserver "say Server will restart in 5 seconds..."
	sleep 5
	sendtoserver "stop"
fi

clear
