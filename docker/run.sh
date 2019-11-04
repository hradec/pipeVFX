#!/bin/bash -l


echo "nameserver 8.8.8.8" > /etc/resolv.conf
cd /atomo/pipeline/build/
[ "$TRAVIS" == "1" ] && rm -rf "/atomo/pipeline/libs/"
mkdir -p /atomo/pipeline/libs/

if [ "$RUN_SHELL" == "1" ] ; then
    bash -i
else
    scons install $EXTRA $DEBUG
fi
