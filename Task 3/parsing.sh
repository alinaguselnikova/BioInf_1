#! /usr/bin/bash
IFS=$'.' var=($(awk -F'mapped [(]|[)]' '{print $2}' output.txt))
echo "$var"
if (($var > 90));
then
	echo OK
else 
	echo Not OK
fi