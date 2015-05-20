#!/bin/bash

# Check the sys info
# Edy
# 20150209

check_listen() {
	netstat -anpt |grep -i listen |awk '{print $NF,$4}'
}

echo "Host `hostname -s` info:" >> /apps/share/hbuser/gather_info/service_info.`hostname -s`
check_listen >> /apps/share/hbuser/gather_info/service_info.`hostname -s`
