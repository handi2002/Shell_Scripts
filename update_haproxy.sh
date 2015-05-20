#!/bin/bash

# update haproxy

MyHost=`hostname`
MyIP=`grep $MyHost /etc/hosts |awk '{print $1}'`

eval sudo sed -i 's/10.168.210.41/$MyIP/g' /etc/haproxy/haproxy.cfg 
sudo /etc/init.d/haproxy restart
