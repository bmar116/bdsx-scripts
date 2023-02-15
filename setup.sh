#!/usr/bin/bash

# wine 32-bit, nodejs-19.x, screen, git required
# install if not present

echo "Installing required commands utilities..."
sudo dpkg --add-architecture i386
curl -sL https://deb.nodesource.com/setup_19.x | sudo bash -
sudo apt-get -q update && sudo apt-get -q install wine nodejs screen git -y

# create required directories if not present
if [ ! -d "/srv/minecraft" ]; then sudo mkdir /srv/minecraft && sudo chown -R "$USER" /srv/minecraft; fi

# setup control scripts and directories
mv bdsx-scripts/minecraft-control.sh ~ && mv bdsx-scripts /srv/minecraft/
chmod +x ~/minecraft-control.sh
cd /srv/minecraft
echo "Installing Bedrock Dedicated Server eXtended (BDSX)..."
git clone https://github.com/bdsx/bdsx.git
mkdir ./bdsx/logs && mkdir ./bdsx/backup
cd bdsx

# install plugins
cd plugins
git clone https://github.com/bmar116/clamor-chatbot.git
git clone https://github.com/bmar116/tpa.git
git clone https://github.com/bmar116/betterchat.git
mkdir web-panel && cd web-panel && wget https://github.com/Rjlintkh/bdsx-web-panel/releases/latest/download/web-panel.zip && unzip web-panel.zip && rm web-panel.zip && cd ..
cd ..

# first run
bash ./update.sh