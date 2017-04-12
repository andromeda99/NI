#!/bin/bash
#*************** The script will calculate the size & number of physical disk on the server ***************
echo -e "\e[1;93m********* HOSTNAME:- $HOSTNAME **********\e[0m"
dsk=0
z=0
x=0
s=0
sub=0
for i in /dev/sd{a..z}
do
	x=`fdisk -l | grep $i | sed -n '1p' | awk '{print $4}' | cut -d, -f1`
	if [ "$x" = "" ]; then
                        echo "=============="
                        #echo "$i does not exist..Accumalating disks......."
                        break
	else
	    	x=`fdisk -l | grep $i | sed -n '1p' | awk '{print $4}' | cut -d, -f1`
		if [ "$x" == "GB" ];then
        		x=`fdisk -l | grep $i | sed -n '1p' | awk '{print $3}'`
			echo "Size of $i is $x GB"
                        dsk=`echo $x + $dsk | bc`
                        d[${sub}]=$i
                        ((sub +=1))
                        f[${s}]=$x
                        ((s +=1))
                        z=`echo $z + 1 | bc`
		else
			x=0
			echo "Size of $i seems to be in MB"
        		x=`fdisk -l | grep $i | sed -n '1p' | awk '{print $3}'`
			echo "Its $x MB..Converting it into GB......"
			sleep 2;
		        x=`echo "scale=2; $x/1024" | bc`
	       		echo "Conversion successful"
			echo "Size of $i is $x GB"
			dsk=`echo $x + $dsk | bc`
	                d[${sub}]=$i
        	        ((sub +=1))
               		f[${s}]=$x
	                ((s +=1))
			z=`echo $z \+ 1 | bc`
		fi
	fi
done
#echo -e "\e[1;38mThere are total $z disks on $HOSTNAME server. Those are ${d[@]} & total size of all disks is $dsk GB \e[0m"
echo -e "\e[1;38mTotal Disks:- $z"
echo -e "\e[1;38mDisks information:-\e[0m"
m=0
#g=0
for i in ${d[@]}
do
	echo "${d[m]} is ${f[g]}"
	((m +=1))
	((g +=1))
done
echo "=============="
echo -e "\e[1;93mTotal Disks Size is:- $dsk GB\e[0m"	


