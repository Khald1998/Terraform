#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo chown -R $USER:$USER /var/www/html
sudo echo "<html><body><h1>Hello from Webserver</h1></body></html>" > /var/www/html/index.html

# Those are alts may or may not work
# sudo bash -c 'echo Hello World! > /var/www/html/index.html'
# echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

