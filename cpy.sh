#!/bin/bash
CP="/bin/cp -p";

prefix=$1;
shift;
target=$1;
shift;
files=$*

case $target in
    \/*) 
    ;;
    *) target=$prefix/$target;
       ;;
esac

if [ ! -d $target ]
then
    echo "Target directory does not exist: $target";
    exit 1;
fi

if [ "x$files" == "x" ]
then
    echo "Empty fileset ";
    exit ;
fi

for file in $files
do
    if [ -f $file ]
    then 
	echo "$CP $file $target";
	/bin/cp -p  $file $target;
    fi
done
