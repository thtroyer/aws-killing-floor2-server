#!/bin/bash

# Add multiverse main to repos and x86 for steamcmd package
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial main universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe multiverse" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb http://archive.ubuntu.com/ubuntu xenial-security main universe multiverse" >> /etc/apt/sources.list'
sudo dpkg --add-architecture i386

# Do upgrades
sudo apt update

sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install debconf-utils htop ncdu unattended-upgrades

# Accept licence agreements
# use debconf-get-selections to find them
echo steamcmd        steam/license   note | sudo debconf-set-selections
echo steamcmd        steam/question  select  I AGREE | sudo debconf-set-selections

#install Steam 
sudo apt -y install steamcmd

# Create initial script
su ubuntu -c 'mkdir /home/ubuntu/games/'
su ubuntu -c 'mkdir /home/ubuntu/games/kf2/'
su ubuntu -c 'touch /home/ubuntu/games/kf2/update.txt'
su ubuntu -c 'echo "login anonymous" >> /home/ubuntu/games/kf2/update.txt'
su ubuntu -c 'echo "force_install_dir /home/ubuntu/games/kf2" >> /home/ubuntu/games/kf2/update.txt'
su ubuntu -c 'echo "app_update 232130 validate" >> /home/ubuntu/games/kf2/update.txt'
su ubuntu -c 'echo "quit" >> /home/ubuntu/games/kf2/update.txt'

# Install KF2
su ubuntu -c 'steamcmd +runscript /home/ubuntu/games/kf2/update.txt'

# Create run script
su ubuntu -c 'echo "/home/ubuntu/games/kf2/Binaries/Win64/KFGameSteamServer.bin.x86_64 kf-bioticslab" > /home/ubuntu/runKf2.sh'
su ubuntu -c 'chmod +x /home/ubuntu/runKf2.sh'
nohup su ubuntu -c 'nohup /home/ubuntu/runKf2.sh'
