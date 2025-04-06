#!/bin/bash

# test-user 계정 생성 및 sudo 권한 부여
useradd test-user --create-home --shell /bin/bash;
echo test-user:test-user | chpasswd
usermod -aG sudo test-user

# nginx 설치 및 실행
apt-get update
apt-get install -y nginx

echo "<h1>Hello vApp's Config Server</h1>" > /var/www/html/index.html

systemctl enable nginx
systemctl start nginx