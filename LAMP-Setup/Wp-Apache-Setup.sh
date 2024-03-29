#date: 03172021-1745
#author: rorudan



# updating os..
sudo apt update -y

sudo apt upgrade -y

# install webserver
sudo apt install apache2 -y

# install mysql dbms
sudo apt install mysql-server mysql-client -y

# install server side script
sudo apt install php7.2 -y

# install some good tools
sudo apt install git unzip curl -y

# install php modules
sudo apt install php7.2-cgi php7.2-curl php7.2-dev php7.2-gd php7.2-intl php7.2-mbstring php7.2-mysql php7.2-xml php7.2-zip -y

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


cd /etc/apache2/sites-available
rm 000-default.conf
wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/LAMP-Setup/wp-apache-000-default.conf -O 000-default.conf
a2enmod rewrite

# restart webserver
service apache2 restart

# create mysql user
mysql -u root -p <<MY_QUERY
create database wordpressdb;
CREATE USER 'admin'@'%' identified by 'password';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';
FLUSH PRIVILEGES;
MY_QUERY
