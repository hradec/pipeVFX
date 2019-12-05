#!/bin/bash -l

env
echo "nameserver 8.8.8.8" > /etc/resolv.conf
cd /atomo/pipeline/build/

if [ "$TRAVIS" == "1" ] ; then
    rm -rf "/atomo/pipeline/libs/*"
    EXTRA="-j 8 $EXTRA"
fi
mkdir -p /atomo/pipeline/libs/

export TERM=xterm-256color

if [ "$RUN_SHELL" == "1" ] ; then
    bash --init-file /atomo/pipeline/tools/init/bash -i
else
    /usr/bin/nice -n 19 scons install $EXTRA $DEBUG
fi
