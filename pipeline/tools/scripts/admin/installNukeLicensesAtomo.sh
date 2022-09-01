#!/bin/bash

rm -rf /dev/shm/foundry
mkdir -p /dev/shm/foundry
cd /dev/shm/foundry/
echo "unzip '$@'"
eval $(echo "unzip '$@'") && \
for ip in 192.168.0.246 192.168.0.245 ; do
	cat /dev/shm/foundry/FoundryLicenseKeys/foundry.lic | sed "s/.server_name./$ip/g" > /dev/shm/foundry/FoundryLicenseKeys/foundry.lic.$ip
	rsync -avpP /dev/shm/foundry/FoundryLicenseKeys/foundry.lic.$ip root@$ip:~/rlm/foundry.lic
	ssh root@$ip '~/rlm/rlmutil rlmreread foundry'
done

