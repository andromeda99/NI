#!/bin/bash
read -p "Enter any four digit number:- " temp
echo $temp
#x=`fdisk -l | grep /dev/sda | sed -n '1p' | awk '{print $4}' | cut -d, -f1`

if [ "$x" == "GB" ];then
	echo "Its GB"
else
	echo "Its MB"
	y=`echo "scale=2; $temp/1024" | bc`
	echo "Now its $y GB"
fi

