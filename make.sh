#!/bin/bash
#
# use this script to build all libraries used by pipeVFX, with all versions
#

CD=$(readlink -f $(dirname $BASH_SOURCE))

SHELL=0
PUSH=0
while getopts hdsbe: option ; do
    case "${option}"
    in
        h) HELP=1;;
        d) DEBUG="debug=1";;
        s) SHELL=1;;
        b) BUILD=1;;
        e) EXTRA="${OPTARG}";;
    esac
done


if [ "$HELP" != "" ] ; then
    echo -e "\n$(basename $0) options:\n"
    echo -e "\t-h   : show this help"
    echo -e "\t-d   : run the build in debug mode (show the build log)"
    echo -e "\t-e   : add extra attributes which will be passed to scons"
    echo -e "\t-s   : run a interactive shell in the docker build container"
    echo -e "\t-b   : build and upload the docker image"
    echo ''
else
    docker pull hradec/pipevfx_centos_base:centos7
    if [ $? != 0 ] ; then
        BUILD=1
    fi

    if [ "$BUILD" == "1" ] ; then
        docker build $CD/docker/ \
            -t hradec/pipevfx_centos_base:centos7 \
            --pull \
            --compress \
            --rm
            
        if [ $? -ne 0 ] ; then
            echo ERROR!!
            exit -1
        else
            docker push hradec/pipevfx_centos_base:centos7
        fi
    fi

    if [ "$SHELL" == "0" ] ; then
        docker run --rm --name pipevfx_make -ti \
            -v $CD/:/atomo/ \
            -v $CD/docker/run.sh:/run.sh \
            hradec/pipevfx_centos_base:centos7 \
            /run.sh $EXTRA $DEBUG
    else
        docker run --rm --name pipevfx_make -ti \
            -v $CD/:/atomo/ \
            -v $CD/docker/run.sh:/run.sh \
            hradec/pipevfx_centos_base:centos7 \
            /bin/bash -c 'echo ". /atomo/pipeline/tools/init/bash" >> $HOME/.bashrc ; bash -l -i '
    fi
fi
