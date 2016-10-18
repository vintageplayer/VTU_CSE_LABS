#!/bin/sh

echo "Enter name of the first file : "
read file1
echo "Enter name of the second file : "
read file2
perm1=`ls -l $file1 2> /dev/null`
if [ $? -eq 2 ]
then
	echo "No file \"$file1\" exists!! Creating it now..."
	touch $file1
	perm1=`ls -l $file1`
fi
perm2=`ls -l $file2 2> /dev/null`
if [ $? -eq 2 ]
then
	echo "No file \"$file2\" exists!! Creating it now..."
	touch $file2
	perm2=`ls -l $file2`
fi
echo "$perm1" | cut -c2-10
echo "#perm2" | cut -c2-10
