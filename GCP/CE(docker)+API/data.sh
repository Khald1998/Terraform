#!/bin/bash
apt-get update
apt-get install ca-certificates
apt-get install curl -y
apt-get install gnupg
apt-get install lsb-release
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo Yes | gcloud auth configure-docker us-central1-docker.pkg.dev
docker pull ${url}
docker run -p 8080:8080 ${url}

