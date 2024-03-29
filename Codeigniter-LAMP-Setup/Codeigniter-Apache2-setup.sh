#!/bin/sh
# author: rorudan
# deployed 03172020-1721

echo "preparing..."
sudo apt update -y

echo "let's upgrade all our resources..."
sudo apt upgrade -y

echo "installing webserver..."
sudo apt install apache2 -y

echo "installing PHP7..."
sudo apt install php7.2 -y

echo "installing Git/Curl/Unzip..."
sudo apt install unzip curl git -y

echo "install PHP modules..."
sudo apt install php7.2-bcmath php7.2-dev php7.2-gd php7.2-imap php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-xml php7.2-zip -y

echo "installing MySQL server/client..."
sudo apt install mysql-server mysql-client -y


# composer
echo 'composer installation...'
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# fetch codeigniter3
wget https://api.github.com/repos/bcit-ci/CodeIgniter/zipball/3.1.11
mv 3.1.11 ci3.zip
unzip ci3.zip
mv bcit-ci-CodeIgniter-* ci_proj

sudo mv ci_proj /var/www/html
sudo chmod -R 775 /var/www/html/ci_proj
sudo chown -R www-data:www-data /var/www/html/ci_proj

# replace config
echo 'setup apache2 config for codeigniter..'
sudo su
cd /etc/apache2/sites-available
rm 000-default.conf
wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/Codeigniter-LAMP-Setup/code.i-000-default.conf -O 000-default.conf
a2enmod rewrite

# restart webserver
service apache2 restart
