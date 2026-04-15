#!/bin/bash

# Update package manager
apt-get update

# Install nginx
apt-get install -y nginx

# Start nginx service
systemctl start nginx

# Enable nginx to start on boot
systemctl enable nginx

# Create a simple health check page
echo "<h1>Nginx Server $(hostname) is Running</h1>" > /var/www/html/index.html

echo "Nginx installation completed on $(date)" >> /var/log/nginx-install.log
