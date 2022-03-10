#!/bin/bash


# root check
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
  echo "Das Script muss als root gestartet werden." 1>&2
  exit 1
fi

apt-get install -y sudo || :
sudo apt-get install -y curl
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/template/master/start.sh --output start.sh
read -t 1
chmod +x start.sh
clear
./start.sh
