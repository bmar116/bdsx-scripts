#!/usr/bin/bash
if [ -x "$(command -v wine)" ] || [ -x "$(command -v wine64)" ]; then
  apt update && apt install wine -y
fi

if [ -x "$(command -v node)" ]; then
  apt update && apt install node -y
fi

mkdir /srv/minecraft && cd /srv/minecraft
git clone https://github.com/bdsx/bdsx.git
mv bdsx-scripts/minecraft-control.sh ~
bash ~/minecraft-control.sh