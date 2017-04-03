#!/bin/bash


function Install_PHP5 {

sudo apt-get update;
echo "INSTALLING APACHE..."
sudo apt-get install -y apache2 php libapache2-mod-php;
echo "INSTALLING MYSQL..."
sudo apt-get install  mysql-server;
echo "INSTALLING PHP5"
sudo apt-get install -y php5 libapache2-mod-php5;
sudo apt-get install -y php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl;
echo "INSTALLING OPEN SSH SERVER"
sudo apt-get install -y openssh-server;
echo "RESTARTING APACHE..."
sudo /etc/init.d/apache2 restart;

}

function Install_PHP7 {

sudo apt-get update;
echo "INSTALLING APACHE..."
sudo apt-get install -y apache2 php libapache2-mod-php;
echo "INSTALLING MYSQL..."
sudo apt-get install  mysql-server;
echo "INSTALLING PHP7.0"
sudo apt-get search php7.0;
sudo apt-get install -y php7.0 libapache2-mod-php7.0 phpmysqli;
sudo apt-get install -y php7.0-mbstring php7.0-mysql php7.0-curl php7.0-json php7.0-mcrypt php7.0-xmlrpc;
sudo apt-get install -y php7.0[TAB];
echo "INSTALLING OPEN SSH SERVER"
sudo apt-get install -y openssh-server;
echo "RESTARTING APACHE..."

sudo /etc/init.d/apache2 restart;


}


function chooseChoices {
echo "*******************************************************"
echo "* [1] Package 1.0                                     *"
echo "*     - Apache2                                       *"
echo "*     - Mysql Server                                  *"
echo "*     - PHP5                                          *"
echo "*     - Open SSH                                      *"
echo "* [2] Package 2.0                                     *"
echo "*     - Apache2                                       *"
echo "*     - Mysql Server                                  *"
echo "*     - PHP7.0                                        *"
echo "*     - Open SSH                                      *"
echo "*******************************************************"
read chosenValue

case $chosenValue in
        "1") Install PHP5 ;;
        "2") Install PHP7 ;;
esac

}

