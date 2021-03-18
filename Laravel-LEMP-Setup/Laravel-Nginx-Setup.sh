#!/bin/bash
#
#
#LEMP Stack Installation
#

#Install git, curl, unzip
sudo apt install unzip curl git -y

#Add Universal
sudo add-apt-repository universe

#update & upgrade
sudo apt update && sudo apt upgrade -y


#Install & Setup Web Server
sudo apt install nginx -y


#Install & Setup Mysql Database
sudo apt install mysql-server mysql-client -y



#Install & Setup PHP
sudo apt install php7.2 -y

#remove package data of apache2 in Php
sudo apt-get purge apache2 -y
sudo apt-get autoremove -y

#install modules
sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-fpm php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli libapache2-mod-php php7.2-dev php7.2-fpm -y


#Create information file
#sudo echo "<?php phpinfo();?>" >> /var/www/html/info.php


# downloading & installing composer for php
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer


# choose type of deployment u want (branch 7.x)
# deploy laravel via git
sudo git clone https://github.com/laravel/laravel.git
cd laravel
sudo git checkout origin/7.x
sudo git checkout -b 7.x
cd

mv laravel /var/www/html

cd /var/www/html/laravel
#go to file /var/

# deploy laravel via composer
sudo composer create-project --prefer-dist laravel/laravel project

# install some dependencies for the project
sudo composer install


# proper permissions for laravel files
sudo chmod -R 775 /var/www/html/laravel
sudo chown -R www-data:www-data /var/www/html/laravel

#config nginx
#sudo ln -s /etc/nginx/sites-available/ .conf
#sudo nano /etc/php7.2/fpm/php.ini     (cgi.fix = 0)
sudo service php7.2-fpm restart



# for migration or fresh laravel project
sudo cp .env.example .env

# generate base64 keys
sudo php artisan key:generate

# edit .env APP_KEY looks something like this
#APP_KEY=base64:HFdS7c9rhDp+AeHu7kc2OLBPuxHqq2BQ/1gfFWEpoAk=

cd
sudo unlink /etc/nginx/sites-enabled/default
sudo unlink /etc/nginx/sites-available/default
cd /etc/nginx/sites-available
sudo wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/Laravel-LEMP-Setup/Laravel-Nginx.conf -O 000-default.conf
cd
sudo ln -s /etc/nginx/sites-available/000-default.conf /etc/nginx/sites-enabled/000-default.conf



sudo service nginx restart
# point the configuration path in public
#/var/www/html/laravel/public
================================
#sudo mysql -u root -p <myQuery
#  CREATE USER 'bindapp'@'localhost' identified by 'bindapp123!@#';
#  GRANT ALL PRIVILEGES ON *.* to 'bindapp'@'localhost';
#  DROP USER ''@'localhost'
#  DROP DATABASE test
#  FLUSH PRIVILEGES;
#myQuery
