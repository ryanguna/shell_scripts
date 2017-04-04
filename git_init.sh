
#!/bin/bash

function changeFolderOwners {

cd $(pwd)
RESOURCES_DIRECTORY="/var/www/html/resources"
VEHICLE_IMAGES_DIRECTORY="/var/www/html/vehicle_images"
OWNER_IMAGES_DIRECTORY="/var/www/html/owner_images"

#ARRAY
arrays=('resources' 'vehicle_images' 'owner_images')
ELEMENTS=${#arrays[@]}

if [ -d ${RESOURCES_DIRECTORY} ] && [ -d ${VEHICLE_IMAGES_DIRECTORY} ] && [ -d ${OWNER_IMAGES_DIRECTORY} ]; then

for (( i=0;i<$ELEMENTS;i++)); do
    sudo chown -R www-data:www-data /var/www/html/${arrays[${i}]}
done

else
        echo e- "Directories |resources|vehicle_images|owner_images are not present.. \n" >> /home/triune/error_logs.txt
fi

}


function checkVersions() {

CHECK_VERSION=$($1 --version)

if [ "${CHECK_VERSION}" != "" ]; then
        echo "$1 this version is installed"
else
        echo "Installing $1..."
        sudo apt-get install $1
fi
}

function versionCheckers {

checkVersions php
checkVersions git
checkVersions mysql
checkVersions nodejs

}

function launchServiceFile {

sudo apt install nodejs-legacy
sudo su<<EOF
SERVICE_FILE="/lib/systemd/system/socket_server.service"
if [ -e ${SERVICE_FILE} ]; then
        echo "File has been created already"
        echo "[Unit]
      Description= TCP/IP & Websocket Server Service File
              Documentation= RyanG
              After=network.target

              [Service]
              Type=simple
              User=triune
              ExecStart=/usr/bin/node /var/www/html/nodejs/NodeJSProject1/socketserver.js
              Restart=on-failure

              [Install]
              WantedBy=multi-user.target" > /lib/systemd/system/socket_server.service

             sudo systemctl daemon-reload
             echo "Creating Socket Server"
             


else
       echo e- "Service file is not configured.. Creating a new Service File" >> /home/triune/error_logs.txt
         echo "[Unit]
              Description= TCP/IP & Websocket Server Service File
              Documentation= RyanG
              After=network.target
              [Service]
              Type=simple
              User=triune
              ExecStart=/usr/bin/node /var/www/html/nodejs/NodeJSProject1/socketserver.js
                          Restart=on-failure

              [Install]
              WantedBy=multi-user.target" > /lib/systemd/system/socket_server.service

             sudo systemctl daemon-reload
             echo "Creating Socket Server"
             
fi
EOF
}


        versionCheckers
        HTML_DIRECTORY="/var/www/html"
        if [ -d ${HTML_DIRECTORY} ]; then
                echo "Configuring HTML directory"
                sudo chown -R triune:triune /var/www/html
                echo "CONFIGURING GIT... PLEASE WAIT YOU MAY ENTER YOUR PASSWORD..."
                cd /var/www/html
                echo "Please enter your GitLab Name"
                read gitLabName
                echo "Please enter your GitLab Username"
                read gitLabUsername
                echo "Enter your GitLab Https: Link" 
                read httpsLink
               
                git config --global --replace-all user.name "$gitLabName"
                git config --global --replace-all user.email "$gitLabUsername"
                git clone $httpsLink .
                changeFolderOwners
                launchServiceFile
        else
                echo e- "HTML Directory is not yet configured\n" >> /home/triune/error_logs.txt
        fi
