#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "<h1>Flentas Cloud Engineer Test - Akash Chaudhary</h1>" > /var/www/html/index.html
