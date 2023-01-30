#!/usr/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

if [ -x "$(command -v wine)" ] || [ -x "$(command -v wine64)" ]; then
  apt update && apt install wine -y
fi

if [ -x "$(command -v node)" ]; then
  apt update && apt install node -y
fi

if [ -x "$(command -v screen)" ]; then
  apt update && apt install screen -y
fi

mkdir /srv/minecraft && cd /srv/minecraft
git clone https://github.com/bdsx/bdsx.git
mv bdsx-scripts/minecraft-control.sh ~
chmod +x ~/minecraft-control.sh
~/minecraft-control.sh