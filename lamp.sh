#!/bin/bash

#Instructions to use this script 
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh


echo "###################################################################################"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "###################################################################################"

#Update the repositories

sudo apt-get update && sudo apt-get upgrade

#Apache, Php, MySQL and required packages installation

sudo apt-get -y install apache2 php libapache2-mod-php php-mcrypt php-curl php-mysql php-gd php-cli php-dev mysql-client
phpenmod mcrypt

#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYPASSWORD123'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYPASSWORD123'
sudo apt-get -y install mysql-server

#Set read/write permissions for apache www folder

sudo chmod 757 -R /var/www/

#Restart all the installed services to verify that everything is installed properly

echo -e "\n"

sudo service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

#Setup firewall permissions and enable for security

sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

if [ $? -ne 0 ]; then
   echo "Please Check the Install Services, There is some $(tput bold)$(tput setaf 1)Problem$(tput sgr0)"
else
   echo "Installed Services run $(tput bold)$(tput setaf 2)Sucessfully$(tput sgr0)"
fi

echo -e "\n"
