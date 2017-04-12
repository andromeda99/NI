#!/bin/bash

temp=" "
echo $temp
regex="^([\s]+)$"
if [[ "$temp" == " " ]]; then
	echo "its a whitespace"
else
	echo "invalid"
fi
