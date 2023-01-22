#!/bin/bash
sudo mkdir /home/ec2-user/'go workspace'
sudo yum update -y
sudo yum install git -y
sudo yum install golang -y
sudo chmod -R a+rw /home
sudo git clone https://github.com/viveksiddhartha/golangapp.git /home/ec2-user/'go workspace'/golangapp
cd 'go workspace'/golangapp
sudo go build -buildvcs=false ./
./main
