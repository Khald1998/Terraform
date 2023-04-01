#!/bin/bash
apt-get update
apt-get install ca-certificates
apt-get install curl -y
apt-get install gnupg
apt-get install lsb-release
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
gcloud auth activate-service-account --key-file=/home/alzahrani_khaled_98/service_account.json
yes | gcloud auth configure-docker
cat /home/alzahrani_khaled_98/service_account.json | docker login -u _json_key --password-stdin \
https://gcr.io
docker pull ${url}
docker run -p 8080:8080 ${url} 
