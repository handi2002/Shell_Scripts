#!/bin/bash

# Setup fw 

# allow internal
iptables -A INPUT -s 10.0.0.0/8  -m state --state NEW -p tcp --dport 22 -j ACCEPT

# allow beijing
iptables -A INPUT -s 159.226.208.99  -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 218.205.177.170  -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 124.65.133.174  -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 210.73.43.73  -m state --state NEW -p tcp --dport 22 -j ACCEPT

# allow chengdu
iptables -A INPUT -s 210.73.43.98  -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 125.69.76.137  -m state --state NEW -p tcp --dport 22 -j ACCEPT

# drop all
iptables -A INPUT -i eth1 -m state --state NEW -p tcp --dport 22 -j DROP

# save rules
service iptables save

# ckconfig iptables 
chkconfig iptables on

# end
