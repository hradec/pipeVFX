#!/bin/bash -l


echo "nameserver 8.8.8.8" > /etc/resolv.conf
cd /atomo/pipeline/build/

if [ "$TRAVIS" == "1" ] ; then
    rm -rf "/atomo/pipeline/libs/*"
    EXTRA="-j 8 $EXTRA"
fi
mkdir -p /atomo/pipeline/libs/

export TERM=xterm-256color


if [ "$RUN_SHELL" == "1" ] ; then
    # set root password to "nopass"
    passwd="nopasswd"
    echo -e "$passwd\n$passwd\n\n" | /bin/passwd -f root 1>/dev/null 2>&1
    # initialize and start dbus
    dbus-uuidgen > /var/lib/dbus/machine-id
    mkdir -p /var/run/dbus
    dbus-daemon \
        --fork \
        --config-file=/usr/share/dbus-1/system.conf \
        --print-address > /var/log/dbus.log 2>&1 &
    # now we can start dbusService.py, which is the way pipeVFX execute commands as root,
    # to create new folders automatically for the current user in a struture which the
    # user has no rights to do it.
    /atomo/pipeline/tools/init/dbusService.py > /var/log/dbusService.log 2>&1 &
    # when running in shell mode, we create the user/group equivalent to the one
    # setup in the distro, so the container runs under the same user and home folder.
    groupadd -g $_GID $_GROUP
    adduser -M $_USER -u $_UID  -g $_GID --shell /bin/bash
    # put user in the sudoers file, without requiring passwd
    echo -e "\n$_USER ALL=(ALL) NOPASSWD: ALL\n" >> /etc/sudoers
    # set pipeVFX init bash script
    echo -e '\n. /atomo/pipeline/tools/init/bash' >> /etc/profile.d/pipevfx.sh
    echo "PS1='pVFX[\u@\h \W]\$ '" >> /etc/profile.d/pipevfx.sh
    echo "export DISPLAY=$DISPLAY" >> /etc/profile.d/pipevfx.sh
    echo "export XAUTHORITY=$XAUTHORITY" >> /etc/profile.d/pipevfx.sh
    echo "export QT_X11_NO_MITSHM=$QT_X11_NO_MITSHM" >> /etc/profile.d/pipevfx.sh
    echo "export http_proxy=$http_proxy" >> /etc/profile.d/pipevfx.sh
    echo "export https_proxy=$https_proxy" >> /etc/profile.d/pipevfx.sh
    chmod a+x /etc/profile.d/pipevfx.sh
    # run bash interactively as $_USER
    runuser -l $_USER
else
    env | egrep 'http|TRAVIS'
    # if we have more than 30GB on the machine, use tmpfs (ramdisk)
    # as the .build folder to speed up the build! (and if not running in parallel)
    if [ $(( $MEMGB / 1024 / 1024 )) -gt 28 ] && [ "$(echo $EXTRA | grep '\-j ')" == "" ] ; then
        echo "Building in ramdisk!!! $EXTRA"
        mount -t tmpfs tmpfs /atomo/pipeline/build/.build
    fi

    # remove boost libraries to avoid building against then.
    mkdir -p /root/source-highlight/libs/
    mv /usr/lib64/libboost_* /root/source-highlight/libs/
    ldconfig

    # we run scons 3 times just in case, since pkgs using
    # cuda may fail to build at first, but build on a second try.
    # also, this accounts for the 2 stage build, when initially there's
    # no libs so we can't build any app dependent package, like cortex
    # for n in {1..3} ; do
        /usr/bin/nice -n 19 scons install $EXTRA $DEBUG
    #     if [ $? -ne 0 ] ; then
    #         echo -e "\n\nERROR: Build did not finished correctly!!\n\n"
    #         break
    #     fi
    # done
fi
