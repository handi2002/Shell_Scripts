#!/bin/bash

# create VG
echo "Checking whether there is VG"

VGs=`vgs 2>/dev/null |wc -l`
if [[ $VGs -eq 0 && "$1" == "create" ]] ; then
	echo "No vgs"
	pvcreate /dev/xvdb
        pvcreate /dev/xvdc
	vgcreate VG-data /dev/xvdb /dev/xvdc
else
	echo "There is VGS"
fi
