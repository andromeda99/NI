#!/bin/bash
read -p "Please enter char value:- " temp
echo "value is $temp"
regex="^([[:alnum:]]*)$"
if [[ "$temp" =~ $regex ]]; then
        echo "Its a string"
else
        echo "Its not a string"
fi
digit=$(grep -o "[0-9]" <<<"$temp")
echo $digit
k=`echo $digit | wc -m`
echo $k
char=$(grep -o "[A-Za-z]" <<<"$temp")
echo $char
m=`echo $char | wc -m`
echo $m



