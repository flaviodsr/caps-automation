#!/bin/bash

cp /etc/group group
docker build --build-arg USER=${USER} --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) -f Dockerfile -t gha-local-runner:latest .
rm group