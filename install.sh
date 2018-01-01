#!/bin/bash

# Add multiverse main to repos and x86 for steamcmd package
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial main universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial-security main universe multiverse" >> /etc/apt/sources.list'
sudo dpkg --add-architecture i386

# Do upgrades
DEBIAN_FRONTEND=noninteractive
sudo apt update
#sudo apt upgrade -y
sudo apt -y install debconf-utils htop ncdu unattended-upgrades

# Accept licence agreements
# use debconf-get-selections to find them
echo steamcmd        steam/license   note | sudo debconf-set-selections
echo steamcmd        steam/question  select  I AGREE | sudo debconf-set-selections

#install Steam 
sudo apt -y install steamcmd

# Create initial script
mkdir /home/ubuntu/games/
mkdir /home/ubuntu/games/kf2/
touch /home/ubuntu/games/kf2/update.txt
echo "login anonymous" >> /home/ubuntu/games/kf2/update.txt
echo "force_install_dir /home/ubuntu/games/kf2" >> /home/ubuntu/games/kf2/update.txt
echo "app_update 232130 validate" >> /home/ubuntu/games/kf2/update.txt
echo "quit" >> /home/ubuntu/games/kf2/update.txt

# Install KF2
steamcmd +runscript /home/ubuntu/games/kf2/update.txt

