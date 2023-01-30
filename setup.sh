#!/usr/bin/bash

if [ -x "$(command -v wine)" ] || [ -x "$(command -v wine64)" ]; then
  sudo apt update && sudo apt install wine -y
fi

if [ -x "$(command -v node)" ]; then
  sudo apt update && sudo apt install node -y
fi

if [ -x "$(command -v screen)" ]; then
  sudo apt update && sudo apt install screen -y
fi

if [ ! -d "/srv/minecraft" ]; then sudo mkdir /srv/minecraft && sudo chown -R "$USER" /srv/minecraft && cd /srv/minecraft; fi
git clone https://github.com/bdsx/bdsx.git
mv bdsx-scripts/minecraft-control.sh ~
chmod +x ~/minecraft-control.sh
~/minecraft-control.sh