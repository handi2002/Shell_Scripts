#!/bin/bash

# Configure ES once installed

cd /apps/share/scripts/deploy_es/
cp elasticsearch.yml.stage.template elasticsearch.yml.stage.`hostname -s`

echo "" >> elasticsearch.yml.stage.`hostname -s`
echo '# Node info' >> elasticsearch.yml.stage.`hostname -s`
echo "node.name: \"`hostname -s`\"" >> elasticsearch.yml.stage.`hostname -s`

cp elasticsearch.sysconfig /etc/sysconfig/elasticsearch
cp elasticsearch.yml.stage.`hostname -s` /etc/elasticsearch/elasticsearch.yml
cp -a ./ik /etc/elasticsearch/
chown -R root:root /etc/elasticsearch/ik

mkdir -p /usr/share/elasticsearch/plugins/
cp -r analysis-ik geohash-facet marvel /usr/share/elasticsearch/plugins/
chown -R root:root /usr/share/elasticsearch/plugins/*

mkdir /etc/elasticsearch/scripts
cp *.groovy /etc/elasticsearch/scripts
chown -R root:root /etc/elasticsearch/scripts
