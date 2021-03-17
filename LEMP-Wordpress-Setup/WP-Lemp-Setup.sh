# Wordpress - NGINX
# author  rorudan
# deployed  03172021-2151


# updating os..
sudo apt update -y

sudo apt upgrade -y

# install webserver
sudo apt install nginx -y

# install mysql dbms
sudo apt install mysql-server mysql-client -y

# install server side script
sudo apt install php7.2 -y

# install some good tools
sudo apt install git unzip curl -y

# install php modules
sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-fpm php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli libapache2-mod-php php7.2-dev php7.2-fpm -y


# remove apache content
sudo apt-get purge apache2
sudo apt-get autoremove


# composer
echo 'composer installation...'
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# replace config in webserver
sudo su
wget https://wordpress.org/latest.tar.gz  
tar -xzvf latest.tar.gz

mv wordpress /var/www/html/
chmod -R 775 /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress


cd /etc/nginx/sites-available
rm default
wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/LAMP-Setup/wp-apache-000-default.conf -O 000-default.conf
cd ..
sudo rm sites-enabled/default
cd

#sym-link
sudo ls -n /etc/nginx/sites-available/000-default.conf /etc/nginx/sites-enables/000-default.conf

# restart webserver
service nginx restart

# create mysql user

