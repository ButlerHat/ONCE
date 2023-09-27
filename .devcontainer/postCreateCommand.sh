#!/bin/bash

export PATH=/opt/flutter/bin:$PATH
# Init Anaconda
conda init bash
# Remove conda activate from bashrc
sed -i '/conda activate/d' ~/.bashrc 
echo "conda activate robotframework" >> ~/.bashrc
. ~/.bashrc
# Init Robotframework
rfbrowser init 
# Init Cron
sudo service cron start
# Init VNC
xrandr -s 1920x1080

/opt/flutter upgrade
/opt/flutter config --enable-web
