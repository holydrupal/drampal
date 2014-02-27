#!/bin/bash

name="${1}";
port="${2:-80}";
if [[ ! -z $1 ]]; then
  echo "Running Drampal with port ${port} and the name ${name}";
  name="--name=${name} ";
else
  name="";
  echo "Running Drampal with port ${port}";
fi
docker run -d -p ${port}:80 ${name}--privileged drampalhub;
