#!/bin/bash -l

env
echo "nameserver 8.8.8.8" > /etc/resolv.conf
cd /atomo/pipeline/build/
[ "$TRAVIS" == "1" ] && rm -rf "/atomo/pipeline/libs/"
mkdir -p /atomo/pipeline/libs/

export TERM=xterm-256color

if [ "$RUN_SHELL" == "1" ] ; then
    bash -i
else
    scons install $EXTRA $DEBUG
fi
