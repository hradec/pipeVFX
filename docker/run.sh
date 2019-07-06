#!/bin/bash


echo "nameserver 8.8.8.8" > /etc/resolv.conf
cd /atomo/pipeline/build/

mkdir /atomo/pipeline/libs/
ls -l /atomo/pipeline/libs/
scons install
