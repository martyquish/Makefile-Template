#!/bin/bash

ret=""
elim=0
# A cleanup script for the object folder.
arr=($(ls -a .objs/*.o))
objs=$(echo $(find . -regextype sed -regex ".*\.\(cc\?\|cpp\)" | tr "\n" " ") | sed "s/\.\(cc\?\|cpp\)/.o/g" | sed "s/\.\//.\/.objs\//g")

for obj in ${arr[@]}
do
    if [[ $objs != *$obj* ]]; then
	elim=1
	ret=$ret$obj", "
	rm $obj
    fi
done



if (( elim > 0 )); then
    echo $ret
else
    echo "none"
fi

