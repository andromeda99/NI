#!/bin/bash
temp=aamir123
digit=$(grep -o "[0-9]" <<<"$temp")
char=$(grep -o "[A-Za-z]" <<<"$temp")
echo "$digit"
echo "$char"
