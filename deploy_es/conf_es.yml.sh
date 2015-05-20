#!/bin/bash

# Configure ES once installed

cd /apps/share/scripts/deploy_es
cp elasticsearch.yml.prod.template elasticsearch.yml.prod.`hostname -s`

echo "" >> elasticsearch.yml.prod.`hostname -s`
echo '# Node info' >> elasticsearch.yml.prod.`hostname -s`
echo "node.name: \"`hostname -s`\"" >> elasticsearch.yml.prod.`hostname -s`

cp elasticsearch.yml.prod.`hostname -s` /etc/elasticsearch/elasticsearch.yml
