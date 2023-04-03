#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# Setup docker repository
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl gnupg vim

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker
VERSION_STRING=5:20.10.18~3-0~ubuntu-focal
sudo apt-get update -y
sudo apt-get install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

# Clone the demo repos and apply patches

# yolov5
repo_name=yolov5-6.2
git clone https://github.com/ultralytics/yolov5.git $repo_name
cd $repo_name
git checkout -b v6.2 v6.2

git apply ../patches/yolov5/*.patch
cd -

# yolov8
repo_name=yolov8-8.0.54
git clone https://github.com/ultralytics/ultralytics.git $repo_name
cd $repo_name
git checkout -q 701fba4
git switch -c $repo_name
git apply ../patches/yolov8/*.patch
cd -

# Linux post-installation steps for Docker
sudo usermod -aG docker $USER
newgrp docker