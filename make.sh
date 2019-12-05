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
    if [ -e /atomo/apps ] ; then
        APPS_MOUNT=" -v /atomo/apps:/atomo/apps "
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

    # if no image in docker hub or we used -b to force a build, build it
    # and push it to docker hub!
    if [ "$BUILD" == "1" ] ; then
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
                --build-arg BASE_IMAGE="$previous_tag"

            if [ $? -ne 0 ] ; then
                echo ERROR!!
                exit -1
            fi
            docker image tag $latest_tag $pkg_image_tag
            docker push $latest_tag
            docker push $pkg_image_tag
        fi

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
            --build-arg PACKAGES="$latest_tag" \
            --build-arg BASE_IMAGE="$base_image"

        if [ $? -ne 0 ] ; then
            echo ERROR!!
            exit -1
        fi
        docker push $build_image
    else
        docker pull $build_image
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
        X11=" -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix  --runtime 'nvidia' "
    fi

    # create lib folder
    mkdir -p "$CD/pipeline/libs/"
    mkdir -p "$CD/pipeline/build/.build/"

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
        $APPS_MOUNT \
        -e RUN_SHELL=$SHELL \
        -e EXTRA=\"$EXTRA\" \
        -e DEBUG=\"$DEBUG\" \
        -e TRAVIS=\"$TRAVIS\" \
        -e http_proxy='$http_proxy' \
        -e https_proxy='$https_proxy' \
        $X11 \
        --privileged \
        $build_image"

    echo $cmd
    eval $cmd
fi
