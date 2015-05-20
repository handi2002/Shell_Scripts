#!/bin/bash

# decomm hosts
for i in `df -h |grep VG`;do sudo umount $i;done
sudo vgremove VG-data
sudo rm -rf /etc/lvm/archive/
