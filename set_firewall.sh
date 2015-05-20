#!/bin/bash

# Setup fw 

# Clear existing rules
iptables -P INPUT ACCEPT
iptables -F
iptables -X
iptables -Z

# allow 

iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth0  -j ACCEPT

# install ipset for ip lists
yum install -y ipset
ipset create ssh-whitelist hash:ip hashsize 4096
# allow Beijing IP
ipset add ssh-whitelist 159.226.208.99
ipset add ssh-whitelist 218.205.177.170
ipset add ssh-whitelist 124.65.133.174
ipset add ssh-whitelist 210.73.43.73
ipset add ssh-whitelist 58.68.234.240/28

# allow chengdu IP
ipset add ssh-whitelist 210.73.43.98
ipset add ssh-whitelist 125.69.76.137

service ipset save
iptables -A INPUT -m set --match-set ssh-whitelist src -p tcp --dport 22 -j ACCEPT

service iptables save
chkconfig iptables on

# Block everything if anything went wrong reset the box to clear rules
iptables -P INPUT DROP

# end
