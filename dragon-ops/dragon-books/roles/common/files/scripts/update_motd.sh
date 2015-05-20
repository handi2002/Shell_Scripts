#!/bin/sh

version=$(cat /etc/redhat-release)
cores=$(cat /proc/cpuinfo |grep proces |wc -l)
ramsize=$(cat /proc/meminfo  |grep MemTotal |awk '{print int($2/1024/1024)}')
let ramsize=$ramsize+1   

cat << EOF > /etc/motd
##############################################
#   Careful: box is managed by Puppet
#
#    OS: $version
#    HW: $cores Cores, $ramsize G RAM 
#
##############################################
EOF
