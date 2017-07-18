#!/bin/sh

if [ $# -ne 2 ]
then
	echo "Invalid arguments!!"
	echo "Exiting..."
	exit
fi

op1="`ls -l $1 2> /dev/null | cut -c1-10`"
op2="`ls -l $2 2> /dev/null | cut -c1-10`"

if [ $op1 = $op2 ]
then
	echo "The two files have same permission."
	echo "The permissions are : "
	echo "$op1"
else
	echo "The two files have different permissions."
	echo "Permissions of file $1 are :"
	echo "$op1"
	echo "Permissions of file $2 are :"
	echo "$op2"
fi
