#!/bin/bash
sleep 30
echo "Install system updates and docker"
sudo apt-get update -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
usermod -a -G docker latest_ubuntu

sudo systemctl start docker

docker swarm join --token SWMTKN-1-69ubosokajcerxhlavhvy22r4j23arkc7qyl4d37gec4v9wint-0z9bqktxvrccxnsmhn2b1uslb 10.0.1.161:2377
