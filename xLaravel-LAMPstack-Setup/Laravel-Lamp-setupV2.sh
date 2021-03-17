#author   rorudan
#deployed   03172021-1758


sudo apt update
sudo apt upgrade -y

sudo apt install git unzip curl -y

sudo apt install php7.2 -y
sudo apt install php7.2-bcmath php7.2-gd php7.2-mbstring php7.2-xml php7.2-mysql php7.2-zip -y 

# dependencies for mcrypt
sudo apt install php7.2-dev libmcrypt-dev php-pear -y

# pecl installation for mcrypt module
sudo pecl channel-update pecl.php.net
sudo pecl install mcrypt-1.0.1

# update php.ini
extension=mcrypt.so

# mysql server / client
sudo apt install mysql-server mysql-client -y

# create user for remote
create user 'hivedevs'@'%' identified by 'hive1234';

# grant privileges
grant all privileges on *.* to 'hivedevs'@'%';

# immediate apply
flush privileges

# downloading & installing composer for php
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# choose type of deployment u want

# deploy laravel via git
git clone https://github.com/laravel/laravel.git

# deploy laravel via composer
composer create-project --prefer-dist laravel/laravel project

# install some dependencies for the project
composer install

# proper permissions for laravel files
chown -R www-data:www-data /var/www/html/laravel
chmod -R 775 /var/www/html/laravel

cd /var/www/html/laravel

# for migration or fresh laravel project
mv .env.example .env

# generate base64 keys
php artisan key:generate

# edit .env APP_KEY looks something like this
APP_KEY=base64:HFdS7c9rhDp+AeHu7kc2OLBPuxHqq2BQ/1gfFWEpoAk=

# dont forget to restart webserver service
sudo a2enmod rewrite
sudo service apache2 restart
