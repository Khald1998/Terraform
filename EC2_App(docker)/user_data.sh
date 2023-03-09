#!/bin/bash
apt-get update
apt-get install ca-certificates
apt-get install curl
apt-get install gnupg
apt-get install lsb-release
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo ${data.aws_ecr_authorization_token.main.password} | docker login --username=${data.aws_ecr_authorization_token.main.user_name} --password-stdin ${aws_ecr_repository.main.repository_url}
docker pull ${format("%v/%v:%v", local.ecr_address, var.repository_name, local.image_tag)}