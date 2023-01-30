#!/usr/bin/bash

if [ ! -x "$(command -v wine)" ] || [ ! -x "$(command -v wine64)" ]; then
  echo "Installing wine..."
  sudo apt-get -q update && sudo apt-get -q install wine -y
fi

if [ ! -x "$(command -v node)" ]; then
  echo "Installing NodeJS..."
  curl -sL https://deb.nodesource.com/setup_19.x | sudo bash -
  sudo apt-get -q update && sudo apt-get -q install nodejs -y
fi

if [ ! -x "$(command -v screen)" ]; then
  echo "Installing screen..."
  sudo apt-get -q update && sudo apt-get -q install screen -y
fi

if [ ! -d "/srv/minecraft" ]; then sudo mkdir /srv/minecraft && sudo chown -R "$USER" /srv/minecraft; fi
mv bdsx-scripts/minecraft-control.sh ~ && mv bdsx-scripts /srv/minecraft/
chmod +x ~/minecraft-control.sh
cd /srv/minecraft
git clone https://github.com/bdsx/bdsx.git
~/minecraft-control.sh
