#!/bin/bash

# create fstab items

FileSystem="/dev/mapper/VG--data-cloudera--monitor" 
FileDirect="/dfs/cloudera-monitor" 
FsType="ext4"
MountOpt="defaults,noatime"

cp /etc/fstab{,.pre`date +%Y-%m-%d`}

echo "$FileSystem	$FileDirect	$FsType	$MountOpt	0 0" >> /etc/fstab
