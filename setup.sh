#!bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo rm -rf /var/www/html/*
sudo git clone https://github.com/Mouryat3007/Ecomm.git /var/www/html