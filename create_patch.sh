#!/bin/bash

mkdir list_patches

for folder in */ ; do
	echo "$folder"
	echo "-------"
	if [[ "$folder" == "$list_patches" ]]; then
		continue
	fi
	mkdir list_patches/$folder

	if [[ "$folder" == "$kernel" ]]; then
		cd $kernel
		git git format-patch HEAD -o ../list_patches/$folder
	fi


done
