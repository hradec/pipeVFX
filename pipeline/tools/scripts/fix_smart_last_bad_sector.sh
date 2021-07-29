#!/bin/bash 

smart="smart-$(basename $1).log"
run="1"
CD=$(dirname $(readlink -f $BASH_SOURCE))
echo start
while [ "$run" == "1" ]  ; do
	
	# if last test has an error, fix it... 
	smartctl -l xselftest -d sat $1 > $CD/$smart
	cat $CD/$smart | egrep '# .*read fail' | while read l ; do
		echo $l
		bad=$(echo $l | awk '{print $(NF)}')
		if [ "$bad" != "-" ] ; then
			echo $bad
			echo $CD/fixhdd.py -a -o $(( $bad - 100 )) -n 200  $1 #| grep -v ignoring
			$CD/fixhdd.py -a -o $(( $bad - 100 )) -n 200  $1 #| grep -v ignoring
		fi
	done
	
	# and start a new test!
	smartctl -t long -d sat $1 > /dev/null
	smartctl -l xselftest -d sat $1 > $CD/$smart


	# check if test is running, and wait if it is... 
	while [ "$(cat $CD/$smart | grep '# 1 ' | grep 'in progress')" != "" ] ; do
		echo -n "$(date) | " ; cat $CD/$smart | grep '# 1 '
		sleep 1200
		smartctl -l xselftest -d sat $1 > $CD/$smart
	done

	while [ "$(cat $CD/$smart | grep 'Self_test_in_progress')" != "" ] ; do
		echo -n "$(date) | " ; cat $CD/$smart | grep 'Self_test_in_progress'
		sleep 1200
		smartctl -l xselftest -d sat $1 > $CD/$smart
	done

	while [ "$(cat $CD/$smart | grep 'The previous self-test')" == "" ] ; do
		sleep 1200
		smartctl -x -d sat $1 > $CD/$smart
		echo -n "$(date) | " ; cat $CD/$smart | grep 'Self-test execution status:' -A1
	done

	# stop if no more errors...
	if [ "$(cat $CD/$smart | grep 'The previous self-test' -A1 | grep failed)" == "" ] ; then
		break
	fi
done
