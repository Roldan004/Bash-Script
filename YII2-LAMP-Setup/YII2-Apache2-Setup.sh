# Get this file and rename it to Vagrantfile , Thanks! ~ Takamata

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "public_network"
  config.vm.provision "shell", inline: <<-SHELL
  
  ======================================================
  
    #LAMP Stack for Yii2
    #Author  rorudan
    #Deployed   03172021-1958

    echo 'updating...'
    sudo apt update -y

    #webserver
    echo 'installing apache2...'
    sudo apt install apache2 -y
   
    #php
    echo 'installing php7.2...'
    sudo apt install php7.2 -y

    #debconf
    echo 'installing debconf...'
    sudo apt-get install -y debconf-utils

    #must have
    echo 'installing unzip curl...'
    sudo apt install git unzip curl -y

    #php modules / dependencies
    echo 'installing php modules...'
    sudo apt install php7.2-bcmath php7.2-curl php7.2-dev php7.2-gd php7.2-json php7.2-mbstring php7.2-mysql php7.2-xml php7.2-zip -y

    # library for webserver and php
    echo 'installing library for apache2 and php...'
    sudo apt install libapache2-mod-php7.2 -y

    #deb conf
    echo export DEBIAN_FRONTEND="noninteractive..."
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password admin"
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password admin"

    # mysql
    echo 'mysql installation for client and server...'
    sudo apt install mysql-server mysql-client -y

    # mongo
    echo 'mongo installation...'
    sudo apt install php-pear php-mongodb -y
    sudo apt install mongodb -y

    # composer
    echo 'composer installation...'
    cd ~
    curl -sS https://getcomposer.org/installer -o composer-setup.php
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

    # fetch yii2 adv
    echo 'setting up yii2...'
      wget https://github.com/yiisoft/yii2/releases/download/2.0.40/yii-advanced-app-2.0.40.tgz

    # extract
    tar -xvzf yii-advanced-app-2.0.40.tgz

    echo 'moving project to web directory..'
    # move files to web dir
    sudo mv advanced /var/www/html/advanced

    # chmod & chown
    echo 'file permissions and group/users..'
    cd /var/www/html
    sudo chmod -R 775 /var/www/html/advanced
    sudo chown -R www-data:www-data /var/www/html/advanced

    # replace config
    echo 'setup apache2 config for yii2..'
    sudo su
      cd /etc/apache2/sites-available
    rm 000-default.conf
    wget https://raw.githubusercontent.com/Roldan004/Bash-Script/main/YII2-LAMP-Setup/Yii2-Lamp-000-default.conf -O 000-default.conf
    a2enmod rewrite
    
    #note: put comment the rewrite before ssl in apache2 configuration
    
    #Install certbot
        #sudo apt install certbot -y
        #sudo add-apt-repository ppa:certbot/certbot
        #sudo apt install python-certbot-apache
        
    #note: uncomment the configuration file
    
    
    cd /var/www/html/advanced
    
    #config the yii2 file
    #cd /var/www/html/advanced
    php init > 0 > yes
   
    #Config the main-local.php
    #sudo nano common/config/main-local.ph


    # restart webserver
    service apache2 restart
    
    
    # create mysql user
    mysql -uroot -p'admin' -e "create database yii2advanced;"
    mysql -uroot -p'admin' -e "grant all privileges on *.* to root@localhost identified by '';"
    
   service mysql restart
    
    #start site
    
    sudo /etc/init.d/apache2 restart.
    service apache2 restart
    
    
    #a2enmod rewrite

  SHELL

end
