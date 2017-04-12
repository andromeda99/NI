#!/bin/bash
regex2="[A-Za-z0-9@$[]{}\|;:,.?/<>~#%^&*()_+-=\s]*"
echo -e  "\e[1;38mPlease enter any Character/Integer/Alphanumeric Value:- \e[0m"
read temp
echo -e "\e[1;38m\t\t********* Value entered is "\"$temp"\" *********\e[0m"
if [[ "$temp" =~ $regex2 ]]
then
d=0
m=0
d=0
w=0
l=0
spch=0
sp=0
z=0
        if [[ "$temp" =~ " " ]]
        then
        echo -e "\e[1;93m\t\t====== "Its an alphanumeric value set" ======\e[0m"
        echo -e "\e[1;93m\tSize of an Integer:- 4 byte    Size of a Character:- 5 byte\e[0m" 
	echo -e "\e[1;93m\tSize of a Special Character:- 5 byte   Size of a Whitespace:- 1 byte\e[0m"
        echo -e "\e[1;38mCalculation:-\e[0m"
        echo -e "\e[1;38m=============\e[0m"
        k=`echo -n "$temp" | wc -c`
        echo -e "\e[1;38mTotal length of string is $k\e[0m"
        digit=$(grep -o "[0-9]" <<<"$temp")
        d=`echo $digit | wc -c`
	d=$((d / 2 ))
        echo -e "\e[1;38mDigits:- $d\e[0m"
        char=$(grep -o "[A-Za-z]" <<<"$temp")
        m=$char
        char=`echo $char | wc -c`
	char=$((char / 2 ))
        echo -e "\e[1;38mChar:- $char\e[0m"
	spch=$(grep -o "[@$[]{}\|;:,.?/<>~#%^&*()_+-=]*" <<<"$temp")
        sp=`echo -n $spch | wc -c`
        echo -e "\e[1;38mSpecial Characters:- $sp\e[0m"
	for (( i=0; i<${#temp}; i++ )); do
	if [[ "${temp:$i:1}" =~ " " ]]
	then
        i=`echo $i \+ 1 | bc`
        #echo "*** whitespace detected on $i position"
        z=`echo $z \+ 1 | bc`
        i=`echo $i \- 1 | bc`
	else
        continue
	fi
	done
	echo -e "\e[1;38mWhitespaces:- $z\e[0m"
        echo -e "\e[1;38mSize of Characters "\"$m"\" is \e[1;93m$char \e[0m\e[1;38mbytes, \e[1;38mSize of Special Characters "\"$spch"\" is \e[1;93m$sp \e[0m\e[1;38mbytes, Size of digits "\"$digit"\" is \e[1;93m$d \e[0m\e[1;38mbytes Size of Whitespace is \e[1;93m$z\e[0m \e[1;38mbytes\e[0m"
        k=`echo $char \+ $d \+ $z  \+ $sp | bc`
        echo -e "\e[1;93\tm===== Total size of variable holding alphanumeric value "\"$temp"\" is $k bytes =====\e[0m"
else
        echo -e "\e[1;93m\t\t====== "Its an alphanumeric value set" ======\e[0m"
 	echo -e "\e[1;93m\tSize of an Integer:- 4 byte    Size of a Character:- 5 byte	 Size of a Special Character:- 5 byte\e[0m"
        echo -e "\e[1;38mCalculation:-\e[0m"
        echo -e "\e[1;38m=============\e[0m"
        k=`echo -n "$temp" | wc -c`
        echo -e "\e[1;38mTotal length of string is $k\e[0m"
        digit=$(grep -o "[0-9]" <<<"$temp")
        d=`echo $digit | wc -c`
        d=$((d / 2 ))
        echo -e "\e[1;38mDigits:- $d\e[0m"
        char=$(grep -o "[A-Za-z]" <<<"$temp")
        m=$char
        char=`echo $char | wc -c`
        char=$((char / 2 ))
        echo -e "\e[1;38mChar:- $char\e[0m"
        spch=$(grep -o "[@$[]{}\|;:,.?/<>~#%^&*()_+-=]*" <<<"$temp")
        sp=`echo -n $spch | wc -c`
        echo -e "\e[1;38mSpecial Characters:- $sp\e[0m"
        echo -e "\e[1;38mSize of characters "\"$m"\" is \e[1;93m$char \e[0m\e[1;38mbytes, \e[1;38mSize of Special Characters "\"$spch"\" is \e[1;93m$sp \e[0m\e[1;38mbytes, Size of digits "\"$digit"\" is \e[1;93m$d \e[0m \e[1;38mbytes\e[0m"
        k=`echo $char \+ $d  \+ $sp | bc`
        echo -e "\e[1;93\tm===== Total size of variable holding alphanumeric value "\"$temp"\" is $k bytes =====\e[0m"
fi
fi
