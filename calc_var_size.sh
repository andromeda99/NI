#!/bin/bash
echo -e  "\e[1;38mPlease enter any Character/Integer/Alphanumeric Value:- \e[0m" 
read temp
echo -e "\e[1;38m\t\t********* Value entered is "\"$temp"\" *********\e[0m"
regex="^([A-Z\s a-z\s]+)$"
regex1="^([0-9]*)$"
regex2="[A-Za-z0-9@$[]{}\|;:,.?/<>~#%^&*()_+-=\s]*"


if [[ "$temp" =~ $regex ]] 
then
	if [[ "$temp" =~ " " ]]
	then
		k=`echo -n "$temp" | wc -c`
		echo "Total length of string is $k"
		char=$(grep -o "[A-Za-z]" <<<"$temp")
		m=`echo $char  | wc -c`
		m=$((m / 2))
		x=`echo $k  \- $m | bc`
		z=$m
		echo -e "\e[1;38m"\"$temp"\" has $x whitespace/s.\e[0m"
		echo -e "\e[1;38m"\"$temp"\" is a $k character word/string with a whitespace & $m without a whitespace.\e[0m"
		echo -e "\e[1;38mEach character holds 4 byte of memory & 1 byte of a whitespace/tab character.\e[0m"
		#echo -e "\e[1;38m"\"$temp"\" has $x whitespace/s.\e[0m"
		m=`echo $m \* 4 | bc`
		m=`echo $m  \+ $x | bc`
	        echo -e "\e[1;93m\t\t====== Size of "\"$temp"\" is ($z[characters] * 4[bytes] + [$x]whitespaces)=$m bytes ======\e[0m"
		else
		k=0
		k=`echo -n "$temp" | wc -c`
		echo -e "\e[1;38m"\"$temp"\" is a $k character word/string & it does not have a whitespace.\e[0m"
		echo -e "\e[1;38mEach character holds 4 byte of memory in a variable.\e[0m"
		echo -e "\e[1;38m"\"$temp"\" is a $k character word/string.\e[0m"
		char=$(grep -o "[A-Za-z]" <<<"$temp")
		k=`echo "$char" | wc -c`
		k=`echo $k  \* 2 | bc`
		echo -e "\e[1;93m\t\t====== Size of a variable holding value "\"$temp"\" is $k bytes ======\e[0m"
		
	fi
elif [[ "$temp" =~ $regex1 ]]
then
	k=`echo -n "$temp" | wc -c`
	echo -e "\e[1;38m"\"$temp"\" is a $k digit integer. Each interger holds 2 byte of memory.\e[0m"
	k=`echo $k \* 2 | bc`
	echo -e "\e[1;93m\t====== Size of a variable holding value "\"$temp"\" is $k bytes ======\e[0m"
elif [[ "$temp" =~ $regex2 ]]
then
d=0
m=0
d=0
w=0
l=0
	if [[ "$temp" =~ " " ]]
	then
	echo -e "\e[1;93m\t\t====== "Its an alphanumeric value set" ======\e[0m"
	echo -e "\e[1;93m\tSize of an Integer:- 2 byte    Size of a Character:- 4 byte Size of a Whitespace:- 1 byte\e[0m"
	echo -e "\e[1;38mCalculation:-\e[0m"
	echo -e "\e[1;38m=============\e[0m"
	k=`echo -n "$temp" | wc -c`
	echo -e "\e[1;38mTotal length of string is $k\e[0m"
	digit=$(grep -o "[0-9]" <<<"$temp")
	d=`echo $digit | wc -m`
	d=$((d / 2))
	echo -e "\e[1;38mDigits:- $d\e[0m"
	char=$(grep -o "[A-Za-z]" <<<"$temp")
	m=$char
        char=`echo $char | wc -c`
        char=$((char / 2))
	echo -e "\e[1;38mChar:- $char\e[0m"
	w=`echo $char \+ $d | bc`
	w=`echo $k \- $w | bc`
	echo -e "\e[1;38mWhitespaces:- $w\e[0m"
	char=`echo $char \* 4 | bc`
	d=`echo $d \* 2 | bc`
	echo -e "\e[1;38mSize of characters "\"$m"\" is \e[1;93m$char \e[0m\e[1;38mbytes, Size of digits "\"$digit"\" is \e[1;93m$d \e[0m\e[1;38mbytes Size of Whitespace is \e[1;93m$w\e[0m \e[1;38mbytes\e[0m"
	k=`echo $char \+ $d \+ $w  | bc`
	echo -e "\e[1;93\tm===== Total size of variable holding alphanumeric value "\"$temp"\" is $k bytes =====\e[0m"
else
	echo -e "\e[1;93m\t\t====== "Its an alphanumeric value set" ======\e[0m"
        echo -e "\e[1;93m\tSize of an Integer:- 2 byte    Size of a Character:- 4 byte\e[0m"
        echo -e "\e[1;38mCalculation:-\e[0m"
        echo -e "\e[1;38m=============\e[0m"
        k=`echo -n "$temp" | wc -c`
        echo -e "\e[1;38mTotal length of string is $k\e[0m"
        digit=$(grep -o "[0-9]" <<<"$temp")
        d=`echo $digit | wc -m`
        d=$((d / 2))
        echo -e "\e[1;38mDigits:- $d\e[0m"
        char=$(grep -o "[A-Za-z]" <<<"$temp")
        m=$char
        char=`echo $char | wc -c`
        char=$((char / 2))
        echo -e "\e[1;38mChar:- $char\e[0m"
        #w=`echo $char \+ $d | bc`
        #w=`echo $k \- $w | bc`
        #echo -e "\e[1;38mWhitespaces:- $w\e[0m"
        char=`echo $char \* 4 | bc`
        d=`echo $d \* 2 | bc`
        echo -e "\e[1;38mSize of characters "\"$m"\" is \e[1;93m$char \e[0m\e[1;38mbytes, Size of digits "\"$digit"\" is \e[1;93m$d \e[0m\e[1;38mbytes\e[0m"
        k=`echo $char \+ $d | bc`
        echo -e "\e[1;93\tm===== Total size of variable holding alphanumeric value "\"$temp"\" is $k bytes =====\e[0m"
	fi
	
else
	echo "Invalid character set"
fi

