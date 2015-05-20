#!/bin/bash

# Configure ES once installed

cd /apps/share/scripts/deploy_es
cp elasticsearch.yml.prod.template elasticsearch.yml.prod.`hostname -s`

echo "" >> elasticsearch.yml.prod.`hostname -s`
echo '# Node info' >> elasticsearch.yml.prod.`hostname -s`
echo "node.name: \"`hostname -s`\"" >> elasticsearch.yml.prod.`hostname -s`

cp elasticsearch.sysconfig.bigmem /etc/sysconfig/elasticsearch
cp elasticsearch.yml.prod.`hostname -s` /etc/elasticsearch/elasticsearch.yml
cp -a ./ik /etc/elasticsearch/
chown -R root:root /etc/elasticsearch/ik

mkdir -p /usr/share/elasticsearch/plugins/
cp -r analysis-ik geohash-facet marvel /usr/share/elasticsearch/plugins/
chown -R root:root /usr/share/elasticsearch/plugins/*

mkdir /etc/elasticsearch/scripts
cp *.groovy /etc/elasticsearch/scripts
chown -R root:root /etc/elasticsearch/scripts
