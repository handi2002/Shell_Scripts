#!/bin/bash

# Usage to clean up the logs
# Edy
# Update: 20150228, Adding clean all if failed too many times

# check our log file size
if [ `du -sk /var/tmp/housekeeping.sh.log|awk '{print $1}'` -gt 485760 ] ;then
	# clean the log file 
	> /var/tmp/housekeeping.sh.log
else
	echo >> /var/tmp/housekeeping.sh.log
	echo `date` >> /var/tmp/housekeeping.sh.log
fi

if [ -f /var/log/mongodb/mongod.log ] ;then
	echo "Clean up Mongodb logs" >> /var/tmp/housekeeping.sh.log
	> /var/log/mongodb/mongod.log
fi

if [ -d /var/log/zookeeper/ ]; then
	echo "Clean zookeeper logs" >> /var/tmp/housekeeping.sh.log
	for i in /var/log/zookeeper/*log.?;do 
		> $i;
	done
fi

echo "Clean App logs" >> /var/tmp/housekeeping.sh.log

# limit size 10G, if > 10G. find the oldest and clean it
Big_Size=10485760
Find_Path=/opt

check_clean() {
	# check the log size
	Drg_Size=`du -sk /opt/stage/bin/logs 2>/dev/null |awk '{print $1}'`
	Api_Size=`du -sk /opt/dragonapi/bin/logs 2>/dev/null |awk '{print $1}'`

	# Deal with it
	if [[ $Drg_Size -gt $Big_Size || $Api_Size -gt $Big_Size ]]; then
		echo "Log size is big, current is $Drg_Size, I will clean" >> /var/tmp/housekeeping.sh.log
		find $Find_Path -name "log.*.log" -mtime +$1 > /var/tmp/housekeeping.sh.cleanlist
		for i in `cat /var/tmp/housekeeping.sh.cleanlist`;do 
			> $i
		done
	else
		echo "Quiet world"
	fi
}

# first clean 7 days old files then 5 3 1, 0.01 days
for mday in 7 5 3 1 ; do 
	if [[ -d /opt/stage/bin/logs || -d /opt/dragonapi/bin/logs ]]; then
		check_clean $mday
	else
		echo "No Application"
	fi
done

# if above doesn't fix, sorry, i will clean all logs
#Log_Fail_Num=`grep 'Log size is big' /var/tmp/housekeeping.sh.log |wc -l`

#if [ $Log_Fail_Num -gt 18 ]; then
#	echo "Sorry, I will clean all" >> /var/tmp/housekeeping.sh.log
#	for i in /opt/dragonapi/bin/logs/* /opt/stage/bin/logs/*; do 
#		echo "Cleaning $i" >> /var/tmp/housekeeping.sh.log
#		> $i
#	done
#fi

# End
