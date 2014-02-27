#!/bin/bash
echo Setting up Ubuntu 13.10 Raring with Docker

# Update & Upgrade
sudo apt-get -y update;
sudo apt-get -y upgrade --show-upgraded;

# Install Docker
sudo apt-get -y install linux-image-extra-`uname -r`;
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9;
sudo sh -c "curl https://get.docker.io/gpg | apt-key add -";
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list";
sudo apt-get -y update;
sudo apt-get -y install lxc-docker;
sudo usermod -a -G docker vagrant;

# Install Tools
sudo apt-get -y install git vim drush;

sudo ln -s /run.sh /usr/local/bin/run;
sudo ln -s /scripts/build.sh /usr/local/bin/build;
