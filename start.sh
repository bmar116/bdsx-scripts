#!/usr/bin/bash
cd /srv/minecraft/bdsx
while :; do
	echo "Starting BDS eXtended server..."
	bash bdsx.sh
	CURRENTDATE=`date +"%Y%m%d-%H%M%S"`
	mv ./logs/latest.log ./logs/${CURRENTDATE}-latest.log
	touch ./logs/latest.log
	echo "Waiting 5 seconds to restart unless Ctrl-C is pressed....."
	sleep 5
done
