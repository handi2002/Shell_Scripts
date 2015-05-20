#!/bin/bash

# Func: update hostname when new host coming

My_IP=`ifconfig eth0 |grep inet |awk  '{print $2}' |cut -d: -f 2 ` 
My_Hostname=`grep $My_IP /etc/hosts |awk '{print $2}'`

#echo $My_IP
echo $My_Hostname
## update hostname
hostname $My_Hostname

## update permanently

sed -i -e '/HOSTNAME/d' /etc/sysconfig/network

echo "HOSTNAME=$My_Hostname" | sudo tee -a /etc/sysconfig/network

## check
echo "My hostname is `hostname` now"
