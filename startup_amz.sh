#!/bin/bash
sleep 20
sudo yum -y update
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
