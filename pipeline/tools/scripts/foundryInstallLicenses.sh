#!/bin/bash

cd /tmp
zip="$HOME/Downloads/FoundryLicenseKeys.zip"

if [ -e $zip ] ; then
	for n in 245 246 247 ; do
		unzip -p $zip | sed 's/.server_name./localhost/g' > ./foundry.lic
		echo rsync -avpP ./foundry.lic root@192.168.0.245:/usr/local/foundry/RLM/ 
		echo ssh root@192.168.0.245 reboot
	done
	rm $zip
fi
