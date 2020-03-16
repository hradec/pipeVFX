#!/bin/bash
# =================================================================================
#
# Automatically sets nimby on afanasy if keyboard or mouse or any other X11 device
# receives input - essentially when X11 leaves idle state!
#
# It also turns off nimby if X11 idle state is more than the number of minutes set
# in idleNimbyOFFminutos variable!
#
# One can use this script to manually set nimby on and off, by calling it with the
# "on" or "off" parameter, like:
#
#    nimby.sh on  - turns nimby on
#    nimby.sh off - turns nimby off
#
# This script relis on idletime shell command to retrieve X11 idle time. It uses
# the same basecode used for X11 screensavers.
#
# =================================================================================

idleNimbyOFFminutos=15

timeOFF=$(( idleNimbyOFFminutos * 60 ))
action=$1

if [ "$1" != "" ] ; then
	# here we use pipe.farm to set nimby for the current machine
	export PYTHONPATH=/atomo/pipeline/tags/latest/python:$PYTHONPATH
	if [ "$action" == "off" ] ; then
		/bin/python2 -c 'import pipe, socket;f=pipe.farm.engine();f._renderNodeSetParameter(socket.gethostname(),"NIMBY",False)'
	elif [ "$action" == "on" ] ; then
		/bin/python2 -c 'import pipe, socket;f=pipe.farm.engine();f._renderNodeSetParameter(socket.gethostname(),"NIMBY",True);f._renderEjectAll(socket.gethostname())'
	fi
	echo "$idle - nimby: $action"
else
   # finds the X servers running, and check idle for all of then
   # this way we can run this as root, and it will query all X servers from other users!
   for n in "$(pgrep -fa Xorg | sed 's/ /\n/g' | egrep run | awk -F'/' '{print $(NF)}')" ; do
	export DISPLAY=$n
	# gets idletime by running the idletime shell command
	export idle=$(idletime)
	if [ "$action" == "" ] ; then
		if [ $idle -lt 15 ] && [ $idle -ge 0 ] ; then
			action="on"
		elif [ $idle -gt $timeOFF ] ; then
			action="off"
		else
			action="no change"
		fi
	fi

	# here we use pipe.farm to set nimby for the current machine
	export PYTHONPATH=/atomo/pipeline/tags/latest/python:$PYTHONPATH
	if [ "$action" == "off" ] ; then
		/bin/python2 -c 'import pipe, socket;f=pipe.farm.engine();f._renderNodeSetParameter(socket.gethostname(),"NIMBY",False)'
	elif [ "$action" == "on" ] ; then
		/bin/python2 -c 'import pipe, socket;f=pipe.farm.engine();f._renderNodeSetParameter(socket.gethostname(),"NIMBY",True);f._renderEjectAll(socket.gethostname())'
	fi
   done
fi
