#!/bin/bash
#Exit status 0 is GB & 1 is MB
pvs | grep /dev/sdb5 | awk '{print $5}' | grep g
q=`echo $?`
echo "Exit status is $q"
m=15.93
if [ "$q" == "1" ];then
	temp=`pvs | grep /dev/sdb5 | awk '{print $5}' | cut -dg -f1 | cut -dm -f1`
	echo "$temp seems to be in MB...Converting it into GB"
	y=`echo "scale=3; $temp/1024" | bc`
	m=`echo $m + $y | bc`
	echo "$temp is now 0$y MB"
	echo "Total is now $m GB"
else
	temp=`pvs | grep /dev/sda2 | awk '{print $5}' | cut -dg -f1 | cut -dm -f1`
	echo "$temp is already in GB"
fi
