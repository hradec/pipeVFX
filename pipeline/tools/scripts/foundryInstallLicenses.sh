#!/bin/bash

run() {
	echo "$@"
	$@
}

cd /tmp
zip="$HOME/Downloads/FoundryLicenseKeys.zip"
if [ "$1" != "" ] ; then
	zip="$1"
fi

if [ -e $zip ] ; then
	for n in 245 246 ; do #247 ; do
		unzip -p $zip | sed 's/.server_name./localhost/g' > /dev/shm/foundry.lic
		run rsync -avpP /dev/shm/foundry.lic root@192.168.0.$n:/root/rlm/foundry.lic
		run ssh root@192.168.0.$n "/bin/bash -c \"pkill -fc -9 rlm ; sleep 15 ; ps -AHfc | grep rlm\"" &
	done
	wait
	echo rm $zip
fi
