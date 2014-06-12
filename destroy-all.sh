#!/bin/bash

for dir in $(ls -d */ | grep ^playground)
do
	cd $dir
	vagrant destroy -f
	cd ../
	rm -Rf $dir
done