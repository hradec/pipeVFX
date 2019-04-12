#!/bin/bash
#
# use this script to build all libraries used by pipeVFX, with all versions
#

CD=$(readlink -f $(dirname $BASH_SOURCE))

docker build $CD/docker/ -t hradec/pipevfx_centos_base:centos7
docker run --rm --name pipevfx_make -ti -v $CD/:/atomo/ -v $CD/docker/run.sh:/run.sh hradec/pipevfx_centos_base:centos7 /run.sh
