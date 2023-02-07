#!/bin/bash
sudo apt update -y
sudo apt install git -y
wget https://storage.googleapis.com/golang/go1.19.5.linux-amd64.tar.gz /home/ubuntu
sudo tar -C /usr/local -xzf go1.19.5.linux-amd64.tar.gz
echo "PATH=$PATH:/usr/local/go/bin" >> /etc/environment
git clone https://github.com/Khald1998/My_REST_API_TEMP.git /home/ubuntu/golangapp
chown ubuntu:ubuntu /home/ubuntu/golangapp
sudo chmod -R 777 /home
git config --global --add safe.directory /home/ubuntu/golangapp
su ubuntu
cd /home/ubuntu/golangapp
go build ./
/home/ubuntu/golangapp/main



