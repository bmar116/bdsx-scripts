#!/usr/bin/bash
cd /srv/minecraft/bdsx
while :; do
	bash bdsx.sh
	echo "Waiting 5 seconds to restart unless Ctrl-C is pressed....."
	sleep 5
done
