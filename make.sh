#!/bin/bash
#
# use this script to build all libraries used by pipeVFX, with all versions
#

CD=$(readlink -f $(dirname $BASH_SOURCE))

# base image from centos used
base_centos=centos:7.6.1810

# base image name for pipeVFX images
base=hradec/pipevfx

# the image name for the image that holds package files (our pkg cache image!)
base_image=${base}_pkgs:centos7

# a tag name so the build image pulls the latest always
pkg_image_tag=${base}_pkgs:centos7_latest


# the build image name!
build_image=${base}_build:centos7

SHELL=0
PUSH=0
while getopts hdsbpe: option ; do
    case "${option}"
    in
        h) HELP=1;;
        d) DEBUG="debug=1";;
        s) SHELL=1;;
        b) BUILD=1;;
        p) PKGS=1;;
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
    if [ -e /atomo/apps ] && [ "$TRAVIS" == "" ] ; then
        APPS_MOUNT=" -v /atomo/apps:/atomo/apps "
    fi
    if [ -e /atomo/jobs ] ; then
        APPS_MOUNT=" $APPS_MOUNT -v /atomo/jobs:/atomo/jobs "
    fi

    latest_tag=$(echo $base_image | awk -F':' '{print $1}'):$(
        wget -q \
        https://registry.hub.docker.com/v1/repositories/"$(echo $base_image | awk -F: '{print $1}')"/tags -O - \
        | tr -d '[]" ' \
        | tr '}' '\n' \
        | awk -F: '{print $3}' \
        | grep -v latest \
        | sort -h | tail -1
    )
    if [ "$latest_tag" == "$(echo $base_image | awk -F':' '{print $1}'):" ] ; then
        latest_tag=$base_image
        previous_tag=$base_centos
    else
        if [ "$PKGS" == "1" ] ; then
            tmp=$latest_tag
            latest_tag=${base_image}_$(echo $latest_tag | awk -Fcentos7_ '{$2++;printf("%04d",$2)}')
            previous_tag=$tmp
        fi
    fi

    # try to pull pkg image from docker hub
    # docker pull $latest_tag
    # if [ $? != 0 ] ; then
    #     BUILD=1
    #     PKGS=1
    # fi
    # # try to pull build image from docker hub
    # docker pull $build_image
    # if [ $? != 0 ] ; then
    #     BUILD=1
    # fi

    if [ "$PKGS" == "1" ] ; then
        echo -e "\n\nusing base_image:$previous_tag \nto build new_tag:$latest_tag\n"
        # packages download
        docker build \
            -f $CD/docker/Dockerfile.pkgs \
            $CD/ \
            -t $latest_tag \
            --pull \
            --compress \
            --rm \
            --build-arg http="$http_proxy" \
            --build-arg https="$https_proxy" \
            # --build-arg BASE_IMAGE="$previous_tag"

        if [ $? -ne 0 ] ; then
            echo ERROR!!
            exit -1
        fi
        docker image tag $latest_tag $pkg_image_tag
        docker push $latest_tag
        docker push $pkg_image_tag
        exit 0
    fi

    # if no image in docker hub or we used -b to force a build, build it
    # and push it to docker hub!
    if [ "$BUILD" == "1" ] ; then

        # build image!
        echo -e "\nusing base_image:$base_image\npackage image:$latest_tag\n\n"
        docker build \
            -f $CD/docker/Dockerfile.build \
            $CD/ \
            -t $build_image \
            --pull \
            --compress \
            --rm \
            --build-arg http="$http_proxy" \
            --build-arg https="$https_proxy" \
            # --build-arg PACKAGES="$latest_tag" \
            # --build-arg BASE_IMAGE="$base_image"

        if [ $? -ne 0 ] ; then
            echo ERROR!!
            exit -1
        fi
        docker push $build_image
    fi

    # use wget proxy setup if it exists
    if [ -e $HOME/.wgetrc ] ; then
        APPS_MOUNT="$APPS_MOUNT -v $HOME/.wgetrc:/root/.wgetrc"
    fi

    TI=" -ti "
    if [ "$TRAVIS" == "1" ] ; then
        TI="-t"
    fi

    X11=""
    if [ "$SHELL" == "1" ] ; then
        X11=" -v /tmp/.X0-lock:/tmp/.X0-lock:rw -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e QT_X11_NO_MITSHM=1 -e DISPLAY -e XAUTHORITY  "
        # if [ "$(which nvidia-smi)" != "" ] ; then
        #     X11="$X11 --runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all "
        # fi

        # instead of using just nvidia custom runtime, we choosed to use the host systems
        # GL libraries, by mounting then to the docker image. This way, the docker
        # image will use libraries compatible with the host video driver, no matter
        # what video driver/manufacturer it is!
        # this seems to work fine with NVidia drivers on arch linux!
        # need more testing on other distros/video board setups.
        # this mode only works if we run the docker container with --privileged!
        extra_libs1=$(ldconfig -p | grep libGL | grep -v GLU |  grep x86 | awk  '{print $NF}' | while read p ; do [ "$p" != "" ] && pp=$(readlink -f $p) && echo -v $pp:/lib64/$(basename $p):ro ; done)
        extra_libs2=$(ldconfig -p | grep libnvidia | grep 440.36 | grep x86 | awk  '{print "-v "$NF":/lib64/"$1":ro"}')
        X11=" $X11 $extra_libs1 $extra_libs2 $extra_libs3 $extra_libs4 "
        # X11=" $X11 --volume /run/dbus/system_bus_socket:/run/dbus/system_bus_socket "

        # and let X accept connections no matter what
        xhost +
    fi

    # create lib folder
    mkdir -p "$CD/pipeline/libs/"
    mkdir -p "$CD/pipeline/build/.build/"

    # this one liner creates the _uid, _user, _gid and _group env vars, so we can
    # pass it on to the docker container.
    # as it uses the id command, it should work on any host distro that has id command
    eval $(echo $(for n in $(id) ; do echo $n | tr '()' ' ' | egrep 'gid|uid' ; done  | awk -F'=' '{print $2}') | awk '{print "export _uid="$1,"; export _user="$2,"; export _gid="$3,"; export _group="$4}')

    # now we can finally run a build!
    cmd="docker rm -f pipevfx_make >/dev/null 2>&1 ; \
        docker pull $build_image ; \
        docker run --rm $TI \
        -v $CD/pipeline/tools/:/atomo/pipeline/tools/ \
        -v $CD/pipeline/libs/:/atomo/pipeline/libs/ \
        -v $CD/pipeline/build/SConstruct:/atomo/pipeline/build/SConstruct \
        -v $CD/pipeline/build/.build/:/atomo/pipeline/build/.build/ \
        -v $CD/docker/run.sh:/run.sh \
        -v $CD/.root:/atomo/.root \
        -v $HOME:/home/$USER/ \
        $APPS_MOUNT \
        -e _UID=$_uid \
        -e _USER=$_user \
        -e _GID=$_gid \
        -e _GROUP=$_group \
        -e RUN_SHELL=$SHELL \
        -e EXTRA=\"$EXTRA\" \
        -e DEBUG=\"$DEBUG\" \
        -e TRAVIS=\"$TRAVIS\" \
        -e http_proxy=\"$http_proxy\" \
        -e https_proxy=\"$https_proxy\" \
        -e MEMGB=\"$(grep MemTotal /proc/meminfo | awk '{print $(NF-1)}')\" \
        $X11 \
        --network=host \
        --privileged \
        $build_image"

    # echo $cmd
    eval $cmd
fi
