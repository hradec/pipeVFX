#!/bin/bash
#
# use this script to build all libraries used by pipeVFX, with all versions
#

CD=$(readlink -f $(dirname $BASH_SOURCE))

echo $CD


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
    # use real apps folder if we have one!
    APPS_MOUNT=" -v $CD/apps:/atomo/apps"
    if [ -e /atomo/apps ] ; then
        APPS_MOUNT=" -v /atomo/apps:/atomo/apps "
    fi

    # try to pull build image from docker hub
    docker pull hradec/pipevfx_centos_base:centos7
    if [ $? != 0 ] ; then
        BUILD=1
    fi

    # if no image in docker hub or we used -b to force a build, build it
    # and push it to docker hub!
    if [ "$BUILD" == "1" ] ; then
        docker build \
            -f $CD/docker/Dockerfile \
            $CD/ \
            -t hradec/pipevfx_centos_base:centos7 \
            --pull \
            --compress \
            --rm \
            --build-arg http="$http_proxy" \
            --build-arg https="$https_proxy"


        if [ $? -ne 0 ] ; then
            echo ERROR!!
            exit -1
        fi

        docker push hradec/pipevfx_centos_base:centos7
    fi

    # use wget proxy setup if it exists
    if [ -e $HOME/.wgetrc ] ; then
        APPS_MOUNT="$APPS_MOUNT -v $HOME/.wgetrc:/root/.wgetrc"
    fi

    TI=" -ti --name pipevfx_make "
    if [ "$TRAVIS" == "1" ] ; then
        TI="-t"
        rm -rf "$CD/pipeline/libs/"
    fi

    # create lib folder
    mkdir -p "$CD/pipeline/libs/"
    mkdir -p "$CD/pipeline/build/.build/"

    # now we can finally run a build!
    cmd="docker run --rm $TI \
        -v $CD/pipeline/tools/:/atomo/pipeline/tools/ \
        -v $CD/pipeline/libs/:/atomo/pipeline/libs/ \
        -v $CD/pipeline/build/SConstruct:/atomo/pipeline/build/SConstruct \
        -v $CD/pipeline/build/.build/:/atomo/pipeline/build/.build/ \
        -v $CD/docker/run.sh:/run.sh \
        -v $CD/.root:/atomo/.root \
        $APPS_MOUNT \
        -e RUN_SHELL=$SHELL \
        -e EXTRA=$EXTRA \
        -e DEBUG=$DEBUG \
        -e TRAVIS=$TRAVIS \
        -e http_proxy='$http_proxy' \
        -e https_proxy=$https_proxy \
        hradec/pipevfx_centos_base:centos7"

    echo $cmd
    eval $cmd
fi
