#!/bin/bash

############################################
################# CHANGE ###################
ver=0.0.1
dat=10.03.2022
filescript=start.sh
link=https://raw.githubusercontent.com/Mobulos/template/master/start.sh
############################################
############################################

#JumpTo Funktion init
function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

#JumpTo Definitionen
menue=${1:-"menue"}
install=${2:-"install"}
update=${3:-"update"}
start=${4:-"start"}

# Farbcodes definieren
red=($(tput setaf 1))
green=($(tput setaf 2))
yellow=($(tput setaf 3))
reset=($(tput sgr0))

#Farbcode beim start reseten
echo "$reset"

#Root Check
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
    echo "Das Script muss als root gestartet werden." 1>&2
    exit 1
fi

#Internet check
if ping -c 1 raw.githubusercontent.com; then
    echo ""
else
    clear
    echo "Es konnte keine Netzwerk Verbindung zu den GitHub Servern hergestellt werden."
    echo "Das Script kann ohne diese Verbindung nicht ausgeführt werden."
    echo "Bitte überprüfe deine Internet Verbingung."
    exit 1
fi

install:
    apt-get update ||:
    apt-get install -y sudo
    apt-get update
    for i in wget
    do
        apt-get install -y $i
    done

menue:
    echo "$yellow########################################"
    read -t0.1
    echo "#####  Temp Script by Mobulos  #####"
    read -t0.1
    echo "########################################"
    read -t0.1
    echo
    echo "$reset"
    read -t0.1
    echo "Version: $ver"
    read -t0.1
    echo "Update vom: $dat"

    tmp=($(tput setaf 2)) && echo "$tmp"
    read -t0.1
    echo "  1. Erster Punkt"

    tmp=($(tput setaf 3)) && echo -n "$tmp"
    read -t0.1
    echo "  2. Script Updaten"

    read -t0.1
    tmp=($(tput setaf 1))
    echo -n "$tmp"
    echo "  3. Exit"

    echo "$reset"
    read -n1 -p "Bot Befehle: " befehl
    case $befehl in
    1)
        clear
        jumpto $start
        exit 0
    ;;
    2)
    clear
    jumpto $update
    exit 0
    ;;
    3)
        clear
        exit 0
    ;;
  	*)
        clear
        echo "Die Eingabe wird nicht Akzeptiert."
        read -t3 -n1
        jumpto $failedmenue
  	;;
    esac

update:
    clear
    echo "Dies kann einige Sekunden dauern."
    read -t3 -n1
    clear
    rm $filescript
    wget $link
    chmod +x $filescript
    clear
    echo "Update abgeschlossen, das Script kann jetzt erneut gestartet werden."
    exit 0
