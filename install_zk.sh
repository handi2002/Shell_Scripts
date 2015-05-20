#!/bin/bash

# Install zookeeper
# 2014-12-04
# Edy

if [ $# -ne 3 ] ;then
	echo ;echo "Sorry, you miss sth"
	echo "Usage: $0 zk_host1 zk_host2 zk_host3"
	echo ;
else
	echo "We are going to rock the world"

	echo "Mking the conf"
	
	cp /apps/share/soft/zoo_sample.cfg /tmp/zk.$1.conf
	echo "server.1=$1:2888:3888
server.2=$2:2888:3888
server.3=$3:2888:3888
" >> /tmp/zk.$1.conf

	for i in $1 $2 $3; do 
		scp /tmp/zk.$1.conf $i:/tmp/
		echo "Install zookeeper packages ...."
		ssh $i "sudo yum --disablerepo=* --enablerepo=alocal clean all"
		ssh $i sudo yum --disablerepo=* --enablerepo=alocal install -y zookeeper zookeeper-server
		MyID=$(grep $i /tmp/zk.temp.conf  |awk -F'=' '{print $1}'|cut -d"." -f2)
		echo "Initialize the zk nodes"
		ssh $i sudo cp /tmp/zk.$1.conf /etc/zookeeper/conf/zoo.cfg
		ssh $i sudo zookeeper-server-initialize --myid=$MyID
		ssh $i sudo chown -R zookeeper:zookeeper /var/lib/zookeeper/
		echo "Start the Zookeeper service"
		ssh $i sudo service zookeeper-server start
	done

	
fi
