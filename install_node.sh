#!/bin/bash

if [ -d /opt/nodejs ] ;then
   echo "NodeJS installed"
else
  echo "Install Nodejs"
  cp -a /apps/share/soft/nodejs /opt/
  chown -R root:root /opt/nodejs
  echo "Install completed"
fi
