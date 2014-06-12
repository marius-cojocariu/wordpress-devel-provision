#!/bin/bash

for dir in $(ls -d */ | grep ^playground)
do
	cd $dir
	vagrant halt
	cd ../
done