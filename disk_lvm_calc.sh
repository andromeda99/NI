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

#==================================calculating LVS on the server
lv=`lvs | wc -l`
lv=`echo $lv \- 1 | bc`
cn=2
#echo -e "\e[1;38mTotal $lv Logical Volume:- \e[0m"
#echo -e "Name   Size"
v=0
w=0
Tlvs=0
p=0
for i in {2..10}
do
        p=`lvs | sed -n "$cn"p | awk '{print $1}'`
        if [ "$p" = "" ];then
                continue
        else
                lvs[${v}]=`lvs | sed -n "$cn"p | awk '{print $1}'`
                lvsS[${w}]=`lvs | sed -n "$cn"p | awk '{print $4}'`
                p=`lvs | sed -n "$cn"p | awk '{print $4}' | cut -dg -f1`
                Tlvs=`echo $p \+ $Tlvs | bc`
                ((cn +=1))
                ((v +=1))
                ((w +=1))
        fi
done
h=0
k=0
for i in ${lvs[@]}
do
        #echo "${lvs[h]}    ${lvsS[k]}"
        ((h +=1))
        ((k +=1))
done
#echo -e "\e[1;38mTotal Size of $lv Logical Volume(LVS):- $Tlvs GB\e[0m"
#echo -e "\e[1;93mPlease follow below LVS mount points with its sizes\e[0m"
#echo -e "\e[1;38mName\t\t    type      Size  Used Avail Use% Mounted\e[0m"
#df -HT | grep vg
#================================
#==================================calculating VGS on the server
vg=`vgs | wc -l`
vg=`echo $vg \- 1 | bc`
cn=2
Tvgs=0
v=0
w=0
p=0
q=0
#echo -e "\e[1;38mTotal $vg Volume Groups:-\e[0m"
#echo -e "Name   Size"
for i in {2..11}
do
        p=`vgs | sed -n "$cn"p | awk '{print $1}'`
        if [ "$p" = "" ];then
        continue
        else
        vgs[${v}]=`vgs | sed -n "$cn"p | awk '{print $1}'`
        vgsS[${w}]=`vgs | sed -n "$cn"p | awk '{print $6}'`
        q=`vgs | sed -n "$cn"p | awk '{print $6}' | cut -dg -f1`
        Tvgs=`echo $q + $Tvgs | bc`
        ((cn +=1))
        ((v +=1))
        ((w +=1))
        fi
done
h=0
k=0
for i in ${vgs[@]}
do
        #echo "${vgs[h]}      ${vgsS[k]}"
        ((h +=1))
        ((k +=1))
done
#echo -e "\e[1;38mTotal Size of Volume Groups(VGS):- $Tvgs GB \e[0m"
#================================
#=======================Calculating PVS on the server
x=0
y=0
z=0
c=0
l=0
for i in  /dev/sd{a..z}
do
        m=`fdisk -l | grep $i | sed -n '1p' | awk '{print $2}' | cut -d: -f1`
        #echo $m
        if [ "$m" = "" ]; then
                break
        else
                for j in {1..11}
                do
                x=`echo $i$j`
                #echo $x
                y=`pvs | grep $x | awk '{print $1}'`
                if [ "$y" = "" ];then
                        continue
                else
                        z[${c}]=`pvs | grep $x | awk '{print $1}'`
                        ((c +=1))
                        l=`echo $l + 1 | bc`
                        #echo "Found partition $i$j added"
                fi
                done
        fi
done
x=0
for i in ${z[@]}
do
        pvs | grep $i | awk '{print $5}' | grep g >> /dev/null
        q=`echo $?`
        #echo "Exit status is $q"
        if [ "$q" == "1" ];then
                temp=`pvs | grep $i | awk '{print $5}' | cut -dg -f1 | cut -dm -f1`
                #echo -e "\e[1;93mSize of $i is $temp MB. Converting it into GB...\e[0m"
                y=`echo "scale=2; $temp/1024" | bc`
                #echo -e "\e[1;93mConversion successfull. $temp MB is now 0$y GB.\e[0m"
                a[${b}]=`pvs | grep $i | awk '{print $5}'`
                x=`echo $x + $y | bc`
		((b +=1))
        else
                temp=`pvs | grep $i | awk '{print $5}' | cut -dg -f1 | cut -dm -f1`
                #echo -e "\e[1;93mSize of $i is $temp GB & its OK...\e[0m"
                a[${b}]=`pvs | grep $i | awk '{print $5}'`
                m=`pvs | grep $i | awk '{print $5}' | cut -dg -f1 | cut -dm -f1`
                x=`echo $x + $m | bc`
                ((b +=1))
        fi
done
#echo -e "\e[1;38mTotal $l Physical Volumes(PVS):-\e[0m"
#echo -e "Name\t\tSize"
h=0
k=0
for i in ${z[@]}
do
        #echo "${z[h]}     ${a[k]}"
        ((h +=1))
        ((k +=1))
done
#echo -e "\e[1;38mTotal Size of PVS:- $x GB\e[0m"
#=====================Printing values
echo -e "\e[1;38mTotal $l Physical Volumes(PVS):-\e[0m"
echo -e "Name\t\tSize"
h=0
k=0
for i in ${z[@]}
do
        echo "${z[h]}     ${a[k]}"
        ((h +=1))
        ((k +=1))
done
echo -e "\e[1;38mTotal Size of PVS:- $x GB\e[0m"
fpvs=`echo "scale=2; $x - $Tvgs" | bc`
echo -e "\e[1;93m*** Free space in PVS is 0$fpvs GB *** \e[0m"
echo -e "\e[1;38mTotal $vg Volume Groups:-\e[0m"
echo -e "Name   Size"
h=0
k=0
for i in ${vgs[@]}
do
        echo "${vgs[h]}      ${vgsS[k]}"
        ((h +=1))
        ((k +=1))
done
echo -e "\e[1;38mTotal Size of Volume Groups(VGS):- $Tvgs GB \e[0m"
fvgs=`echo "scale=2; $Tvgs - $Tlvs" | bc`
echo -e "\e[1;93m*** Free space in VGS is 0$fvgs GB *** \e[0m"
echo -e "\e[1;38mTotal $lv Logical Volume:- \e[0m"
echo -e "Name   Size"
h=0
k=0
for i in ${lvs[@]}
do
        echo "${lvs[h]}    ${lvsS[k]}"
        ((h +=1))
        ((k +=1))
done
echo -e "\e[1;38mTotal Size of $lv Logical Volume(LVS):- $Tlvs GB\e[0m"
echo -e "\e[1;93mPlease follow below LVS mount points with its sizes\e[0m"
echo -e "\e[1;38mName\t\t    type      Size  Used Avail Use% Mounted\e[0m"
df -HT | grep vg
#=========================
Tdsk=`echo $dsk \- $x | bc`
echo -e "\e[1;93m*** Free & Available space on the disk is $Tdsk ***\e[0m"
