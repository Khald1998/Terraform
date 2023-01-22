#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo chown -R $USER:$USER /var/www/html
sudo echo "<html><body><h1>Hello from Webserver</h1></body></html>" > /var/www/html/index.html
