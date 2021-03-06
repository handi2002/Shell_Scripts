#!/bin/bash

# Sync from Prod to Staging

if [ $# -ne 1 ] ;then
        echo "Usage: $0 tb_list_file"
        exit 0
fi

Tb_List=$1

# Make snapshot
for i in `cat $Tb_List`;do
        echo "Take snapshot for table: $i"
#       echo list_snapshots |hbase shell
        echo "snapshot '$i', '"$i"_`date +%Y_%m_%d`'" | hbase shell
#       echo list_snapshots |hbase shell
        echo "snapshot '$i', '"$i"_`date +%Y_%m_%d`'" > stage.info
done

# sycn table info to staging
scp stage.info srmhb01:~/

# Copy
for i in `cat $Tb_List`;do 
        echo "Sync Table $i...."
#       hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot snap-$i -copy-to hdfs://srmhb01:8020/hbase
        hbase org.apache.hadoop.hbase.snapshot.ExportSnapshot -snapshot "$i"_`date +%Y_%m_%d` -copy-to hdfs://srmhb01:8020/hbase
done

# Clean snapshot
echo "Will clean Snapshot now"
echo -n "Yes(y) or No(n): "
read RYoN
if [ "$RYoN" == "y" ]; then
        for i in `cat $Tb_List`;do
                echo "Cleanup snapshot for table $i..."
                echo "delete_snapshot '"$i"_`date +%Y_%m_%d`'" |hbase shell
        done
else
        echo "Quiting, Bye Dude" 
        exit
fi