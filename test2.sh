#!/bin/bash

read -p "Please enter char value:- " temp
echo "value is $temp"
regex="^([A-Za-z\s A-Za-z]+)$"
if [[ "$temp" =~ $regex ]]; then
	echo "Its a string"
else
	echo "Its not a string"
fi
