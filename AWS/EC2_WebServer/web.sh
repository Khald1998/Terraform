#!/bin/bash
apt update -y
apt install apache2 -y
systemctl status apache2
systemctl start apache2
systemctl enable apache2
chown -R $USER:$USER /var/www/html
echo "<html><body><h1>Hello from Webserver</h1></body></html>" > /var/www/html/index.html
