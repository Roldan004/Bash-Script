#author   rorudan
#deployed   03172021-1758


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
sudo apt install apache2 -y


#Install & Setup Mysql Database
sudo apt install mysql-server mysql-client -y


#Install & Setup PHP
sudo apt install php7.2 -y

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


# for migration or fresh laravel project
sudo cp .env.example .env

# generate base64 keys
sudo php artisan key:generate


# proper permissions for laravel files
sudo chmod -R 775 /var/www/html/laravel
sudo chown -R www-data:www-data /var/www/html/laravel

#config nginx
#sudo ln -s /etc/nginx/sites-available/ .conf
#sudo nano /etc/php7.2/fpm/php.ini     (cgi.fix = 0)
sudo service php7.2-fpm restart


# edit .env APP_KEY looks something like this
#APP_KEY=base64:HFdS7c9rhDp+AeHu7kc2OLBPuxHqq2BQ/1gfFWEpoAk=

cd
cd /etc/apache2/sites-available
sudo rm 000-default.conf
sudo wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/xLaravel-LAMPstack-Setup/Laravel-Apache2-000-default.conf -O 000-default.conf
cd
a2ensite 000-default.conf

# dont forget to restart webserver service
sudo a2enmod rewrite
sudo service apache2 restart
