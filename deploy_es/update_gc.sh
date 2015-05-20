#!/bin/bash

# update gc

if [ `grep ES_HEAP_SIZE=32g /etc/sysconfig/elasticsearch|wc -l` -ne 1 ]; then
	echo "Useing small one"
	cp /etc/sysconfig/elasticsearch{,.pre20150430}
	cp /apps/share/scripts/deploy_es/elasticsearch.sysconfig /etc/sysconfig/elasticsearch
else
	echo "Using big one"
	cp /etc/sysconfig/elasticsearch{,.pre20150430}
	cp /apps/share/scripts/deploy_es/elasticsearch.sysconfig.bigmem /etc/sysconfig/elasticsearch
fi
