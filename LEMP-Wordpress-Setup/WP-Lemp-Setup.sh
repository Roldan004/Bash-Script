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


# remove apache content
sudo apt-get purge apache2 -y
sudo apt-get autoremove -y

# install some good tools
sudo apt install git unzip curl -y

# install php modules
sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-fpm php7.2-gd php7.2-intl php7.2-mbstring php7.2-xml php7.2-zip php7.2-mysql php-cli php7.2-dev php7.2-fpm -y


# composer
echo 'composer installation...'
cd ~
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# replace config in webserver
sudo wget https://wordpress.org/latest.tar.gz  
tar -xzvf latest.tar.gz

sudo mv wordpress /var/www/html/
sudo chmod -R 775 /var/www/html/wordpress
sudo chown -R www-data:www-data /var/www/html/wordpress


cd /etc/nginx/sites-available
cd
sudo unlink /etc/nginx/sites-enabled/default
sudo unlink /etc/nginx/sites-available/default
sudo wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/LEMP-Wordpress-Setup/wp-lemp.conf -O 000-default.conf

#sym-link
sudo ln -s /etc/nginx/sites-available/000-default.conf /etc/nginx/sites-enabled/000-default.conf


sudo service nginx reload


# restart webserver
sudo service nginx restart
