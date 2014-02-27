#!/bin/bash

# LAMP Components
echo "<========== LAMP ==========>";
echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y install \
mysql-client \
mysql-server \
apache2 \
libapache2-mod-php5 \
pwgen \
python-setuptools \
php5-mysql

echo "<========== Drampal ==========>";
echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list;
apt-get update;
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
DEBIAN_FRONTEND=noninteractive apt-get -y install \
wget \
openssh-server \
curl \
php5-curl \
php5-mcrypt \
php5-ffmpeg \
php5-imagick \
vim \
drush \
ruby1.9.3

# Ruby
gem install bundler
gem install compass
gem install bourbon
gem install susy

# Git
apt-get -y install python-software-properties
add-apt-repository -y ppa:git-core/ppa
apt-get update
apt-get -y install git

# Get Subtree
mkdir -p /apps
git clone https://github.com/apenwarr/git-subtree.git /apps/subtree
ln -s /apps/subtree/git-subtree.sh /usr/local/bin/git-subtree

# Load apache mod_rewrite
a2enmod rewrite;
