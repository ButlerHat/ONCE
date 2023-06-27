#!/bin/bash

export PATH=/opt/flutter/bin:$PATH
# Init Anaconda
conda init bash 
rfbrowser init 
# Init Cron
sudo service cron start
# Init VNC
xrandr -s 1920x1080

/opt/flutter upgrade
/opt/flutter config --enable-web
