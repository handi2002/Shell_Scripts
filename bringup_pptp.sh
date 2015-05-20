#!/bin/bash

# Bring up VPN for jmeter

pptpsetup --delete  vpn

sleep 10

if [ `ifconfig ppp0 2>/dev/null;echo $?` -eq 0 ]; then
	echo "PPP0 is there, please check manually"
	exit
else
	echo "Will create VPN"
	pptpsetup --create vpn --server prmcr28 --username `hostname -s` --password 0jgong --encrypt --start
	route add -net 192.168.0.0 netmask 255.255.255.0 dev ppp0
fi
