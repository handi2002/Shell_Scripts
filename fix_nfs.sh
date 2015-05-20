#!/bin/bash

# fix nfs if there is reboot on nfs server 
# Date : 2014-12-04

MoutFS=`mount |grep prmmg01|grep -v grep | wc -l`
if [ $MoutFS -ne 0 ]; then
	echo "`hostname` has nfs mount, need to be fixed"
	echo "Will fix it now"
	umount -lf /apps/share
	mount prmmg01:/apps/share /apps/share
else
	echo "`hostname` is All fine"
fi
