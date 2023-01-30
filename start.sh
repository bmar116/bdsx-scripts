#!/usr/bin/bash
cd /srv/minecraft/bdsx
while :; do
	bash bdsx.sh
	CURRENTDATE=`date +"%Y%m%d-%H%M%S"`
	mv ./logs/latest.log ./logs/${CURRENTDATE}-latest.log
	echo "Waiting 5 seconds to restart unless Ctrl-C is pressed....."
	sleep 5
done
