#!/usr/bin/env bash

#Apache
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#firewalld
sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service

#MariaDB
sudo yum -y remove mariadb*
sudo rm -rf /var/lib/mysql/

#wget
sudo yum -y install wget

#vim 
sudo yum -y install vim

#MySQL
sudo wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
sudo rpm -Uvh mysql-community-release-el7-5.noarch.rpm
sudo sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo
sudo yum -y --enablerepo=mysql56-community install mysql-community-server 
sudo systemctl start mysqld.service
sudo systemctl enable mysqld.service
sudo mysql -u root -e "SET PASSWORD FOR root@localhost = PASSWORD('root');"

#PHP
sudo yum -y install php php-mysql php-mbstring
sudo systemctl restart httpd.service

#phpMyAdmin
sudo yum install -y epel-release
sudo yum install --enablerepo=epel -y phpMyAdmin
sudo cp -f /etc/httpd/conf.d/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf.bak
sudo cp -f /vagrant/vagrant/conf/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf
sudo systemctl restart httpd.service

# chmod
sudo chmod -R 777 /var/www/html