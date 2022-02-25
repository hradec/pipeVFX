#!/bin/bash

export PATH=/bin:/usr/bin:/sbin:/usr/sbin

p=$(pgrep -fa 'bash.*keep_network_online')
np=$(echo "$p" | egrep -vi 'cron|grep|^$' | wc -l)
#echo "$p"
#echo "$np"
[ $np -gt 1 ] && exit 0

log=/var/log/keep_network_online.log
while true ; do
	# keep nic with ip address
	for n in $(ifconfig -a | egrep '^eth' | awk -F':' '{print $1}') ; do
		ip=$(ifconfig $n | grep 'inet ' | awk '{print $2}')
		if [ "$ip" == "" ] ; then
			pkill -fc -9 dhclient.*$n
			d=$(pgrep -fa dhclient.*$n | wc -l)
			if [ $d -eq 0 ] ; then
				echo dhclient
				dhclient $n > $log 2>&1 &
			fi
		fi
	done

	# make sure gateway is removed
	if [ "$(route -n | grep UG)" != "" ] ; then
		route del default > $log 2>&1 &
	fi
	sleep 5
done
