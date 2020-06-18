#!/bin/sh
sudo yum install -y yum-utils

# install docker
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum-config-manager --save --setopt=download.docker.com_linux_centos_docker-ce.reposudo.skip_if_unavailable=true
sudo yum update -y
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker vagrant
sudo systemctl start docker

# install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install git
sudo apt-get install git -y

# Setup environment
mkdir ./docker
echo """version: '2'
v
services:
  mysql:
    image: mysql:5.7
    restart: always
    ports:
      - 8081:3306
    environment:
      MYSQL_USER: wordpress
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_PASSWORD: wordpress

  wordpress:
    depends_on:
      - mysql
    image: wordpress
    ports:
      - 8080:80
    restart: always
    environment:
      WORDPRESS_DB_HOST: mysql:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress"""  > ./docker/docker-compose.yml
docker-compose up -d      