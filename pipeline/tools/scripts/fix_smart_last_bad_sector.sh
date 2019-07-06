#!/bin/bash 

r=$(/bin/python2 -c 'for n in range(8): print n,')
echo $r

run="1"
while [ "$run" == "1" ]  ; do
	smartctl -t long $1 > /tmp/null
	smartctl -a $1 > /tmp/smart
	echo "$(cat /tmp/smart | grep '# 1 ' | grep 'in progress')" 
#	while [ "$(cat /tmp/smart | grep '# 1 ' | grep 'in progress')" != "" ] ; do
#		cat /tmp/smart | tail -10 | grep progress
#		sleep 5
#		smartctl -a $1 > /tmp/smart
#		cat /tmp/smart | grep '# 1 '
#	done
#	while [ "$(cat /tmp/smart | grep 'Self-test execution status:' | grep -v 'The previous self-test routine completed$')" != "" ] ; do
#		cat /tmp/smart | tail -10 | grep completed
#		sleep 5
#		smartctl -a $1 > /tmp/smart
#		cat /tmp/smart | grep 'Self-test execution status:' -A1
#	done

	bad=$(echo $(cat /tmp/smart |grep "# 1 ") | cut -d" " -f10)
	echo $bad 
	if [ "$bad" != "-" ] ; then
		for n in $r ; do
			let b1=$bad+$n
			echo hdparm --repair-sector $b1  --yes-i-know-what-i-am-doing  $1
			hdparm --repair-sector $b1  --yes-i-know-what-i-am-doing  $1 >> /tmp/smart_repaired.log
		done
		tail -n 60 /tmp/smart_repaired.log | grep writing | tail -n 20
		grep '#' /tmp/smart | head -5
		hdparm -I $1 > /tmp/hdparm
		sleep 5
	else
		run=0
	fi
done

