#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<h1>Greetings from $(hostname -f)</h1>" > /var/www/html/index.html