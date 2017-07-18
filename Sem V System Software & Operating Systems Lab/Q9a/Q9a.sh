#!/bin/sh

if [ $# -eq 0 ]
then
	echo "Invalid arguments!!"
	echo "Exiting..."
	exit
fi
for i in $@
do
	echo "echo \"Extracting $i..\"" >> bundle.sh
	echo "cat > $i << EOF" >> bundle.sh
	cat $i >> bundle.sh
	echo "EOF" >> bundle.sh
done
