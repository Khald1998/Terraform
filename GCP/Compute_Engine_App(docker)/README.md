gcloud auth activate-service-account --key-file=/home/alzahrani_khaled_98/service_account.json
gcloud auth configure-docker -y
sudo usermod -a -G docker ${USER}
cat /home/alzahrani_khaled_98/service_account.json | docker login -u _json_key --password-stdin \
https://gcr.io

docker login registry-access@terraform-31308.iam.gserviceaccount.com

docker pull gcr.io/terraform-31308/test:1680178822