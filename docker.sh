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
sudo yum install git -y

# Setup environment
sudo echo """version: '3'

services:
  mysql:
    image: mariadb
    restart: always
    ports:
      - 8081:3306
    volumes:
      - ./db_data:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin
    environment:
      PMA_ARBITRARY: 1
      MYSQL_ROOT_PASSWORD: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    restart: always
    ports:
      - 8082:80
    links:
      - mysql

  wordpress:
    depends_on:
      - mysql
    image: wordpress
    ports:
      - 8080:80
    restart: always
    volumes:
      - ./wordpress:/var/www/html
    links:
      - mysql
    environment:
      WORDPRESS_DB_HOST: mysql:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress"""  > ./docker/docker-compose.yml