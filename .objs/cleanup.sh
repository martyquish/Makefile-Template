#!/bin/bash

echo "Cleaning up object folder..."
# A cleanup script for the object folder.
arr=($(ls -a .objs/*.o))
objs=$(echo $(find . -regextype sed -regex '.*\.\(cc\?\|cpp\)' | tr '\n' ' ') | sed 's/\.\(cc\?\|cpp\)/.o/g' | sed 's/\.\//.\/.objs\//g')

for obj in ${arr[@]}
do
    if [[ $objs != *$obj* ]]; then
	rm $obj
    fi
done
echo "Done!"
