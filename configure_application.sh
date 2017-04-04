#!/bin/bash

function PHP_database_credentials {
echo "Enter PHP MySQL Username:"
read mysqlUsername
echo "Enter PHP MySQL Password:"
read mysqlPassword
sed -i "s/mysql_username/$mysqlUsername/g" /var/www/html/database_connect.php
sed -i "s/mysql_password/$mysqlPassword/g" /var/www/html/database_connect.php
}

function NodeJS_database_credentials {

echo "Enter NodeJS MySQL Username:"
read nodejsDatabaseUsername
echo "Enter NodeJS MySQL Password:"
read nodejsDatabasePassword
sed -i "s/mysql_username/$nodejsDatabaseUsername/g" /var/www/html/nodejs/NodeJSProject1/mysqlfile.js
sed -i "s/mysql_password/$nodejsDatabasePassword/g" /var/www/html/nodejs/NodeJSProject1/mysqlfile.js

}

function TCP_server_host_port {

echo "Enter TCP Server Host:"
read tcpServerHost
echo "Enter TCP Server Port:"
read tcpServerPort

sed -i "s/TCP_server/$tcpServerHost/g" /var/www/html/nodejs/NodeJSProject1/TCPserver.js
sed -i "s/TCP_port/$tcpServerPort/g" /var/www/html/nodejs/NodeJSProject1/TCPserver.js
sed -i "s/TCP_server/$tcpServerHost/g" /var/www/html/js/functions/functions.js

}

function NodeJS_SocketIO_port {

echo "Enter NodeJS Socket IO Port:"
read nodejsSocketIOPort
sed -i "s/socketIOPort/$nodejsSocketIOPort/g" /var/www/html/nodejs/NodeJSProject1/SocketIOServer.js
sed -i "s/socketIOPort/$nodejsSocketIOPort/g" /var/www/html/js/functions/functions.js

}


function chooseChoices {
echo "*******************************************************"
echo "* [1] PHP MySQL database credentials.                 *"
echo "* [2] NodeJS Server MySQL database credentials.       *"
echo "* [3] Configure TCP Server host and port.             *"
echo "* [4] Configure WebSocket Server host and port.       *"
echo "* [5] Configure from the start.                       *"
echo "*******************************************************"
read chosenValue

case $chosenValue in
        "1") PHP_database_credentials ;;
        "2") NodeJS_database_credentials ;;
        "3") TCP_server_host_port ;;
        "4") NodeJS_SocketIO_port ;;
        "5") PHP_database_credentials
             NodeJS_database_credentials
             TCP_server_host_port
             NodeJS_SocketIO_port;;
esac
}

sudo systemctl start socket_server
sudo systemctl enable socket_server

echo "Welcome! Please choose which kind of installation you wish to proceed."
chooseChoices

