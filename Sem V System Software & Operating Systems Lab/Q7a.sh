#!/bin/sh

# Checking if any parameters are passed
if [ $# -eq 0 ]
then
	echo "No parameters passed!!"
else
	# Declaring a variable to store the reversed list
	res=''

	# Traversing through each argument passed one at a time
	for x in $@
	do
		# Adding the latest argument in front of the list
		res=$x" "$res
	done
	echo "The parametes in reverse order are :"
	echo "$res"
fi
