#!/bin/bash

# Func: update hostname when new host coming

My_IP=`ifconfig eth0 |grep inet |awk  '{print $2}' |cut -d: -f 2 ` 

echo $My_IP

## update NRPE

echo "server_address=$My_IP" | sudo tee -a /usr/local/nagios/etc/nrpe.cfg

## check
echo `sudo grep server_address /usr/local/nagios/etc/nrpe.cfg`

## bounce opsview
sudo /etc/init.d/opsview-agent restart

## check 5666
netstat -ant |grep 5666
