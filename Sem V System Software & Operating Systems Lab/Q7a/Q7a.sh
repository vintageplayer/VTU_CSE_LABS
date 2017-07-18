#!/bin/sh
if [ $# -eq 0 ]
then
	echo "Invalid number of arguments!!"
	echo "Exiting..."
	exit
fi

echo "$# parameter(s) found.\n"
echo "Parameter in entered order are :\n$@\n"
echo "Parameters in reverse order are :"
rev=""
for x in $@
do
	rev=$x" "$rev
done
echo "$rev"
