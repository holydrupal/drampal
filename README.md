# Drampal

This project is all about creating the simplest path of using vagrant to load docker to load a Drupal site. I've tried to remove all excess fat along the way.

What you can do is fork this project to your own GitHub account, then commit after Docker build to an image on the Docker Index. You could then sync the two and would have your own Drupal development environment out-of-the-box.

# Installation
1. Install Virtual Box
2. Install Vagrant
3. Install Git

## Clone Drampal
[Drampal](https://bitbucket.org/holydrupal/drampal)

```bash
git clone git@bitbucket.org:holydrupal/drampal.git
```

## Vagrant Up
```bash
cd drampal
# Can use environment variables (i.e. IP_ADDRESS="10.0.0.101" vagrant up)
# Also change your C:\Windows\System32\drivers\etc\hosts file (i.e. 10.0.0.101 drampal.dev)
vagrant up
```
And you're up and running with [Docker](https://www.docker.io)

# Building Drampal
```bash
cd docker
docker build -t drampal drampal
# or
. build.sh drp
```
## Starting Drampal
```bash
# to run it as is
docker run drampal
# or to just run the server in the background
docker run -d drampal
# or for a command prompt
docker run -i -t -p 80:80 /bin/bash
```
## Access the bash from another terminal
```bash
docker ps -notrunc
# copy container ID
sudo lxc-attach -n {containerID}
```
