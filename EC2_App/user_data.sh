#!/bin/bash
apt update -y
apt install git -y
apt install golang -y
git clone https://github.com/viveksiddhartha/golangapp.git /home/ubuntu/golangapp
chown ubuntu:ubuntu /home/ubuntu/golangapp
cd /home/ubuntu/golangapp
sudo -u ubuntu go build /home/ubuntu/golangapp/
/home/ubuntu/golangapp/main



