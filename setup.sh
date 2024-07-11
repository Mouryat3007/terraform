#!bin/bash
sudo apt update -y
sudp apt install nginx
sudo rm -rf /var/www/html/*
sudo git clone https://github.com/Mouryat3007/Ecomm.git /var/www/html