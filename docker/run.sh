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
    # we run scons 3 times just in case, since pkgs using
    # cuda may fail to build at first, but build on a second try.
    # also, this accounts for the 2 stage build, when initially there's
    # no libs so we can't build any app dependent package, like cortex
    for n in {1..3} ; do
        /usr/bin/nice -n 19 scons install $EXTRA $DEBUG
    done
fi
