#!/bin/bash

# Update package lists
sudo apt-get update

# Install Nginx
sudo apt-get install nginx -y

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a simple index.html page
echo "<h1>Terraform in one shot by sachin</h1>" | sudo tee /var/www/html/index.html

