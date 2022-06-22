FROM hradec/pipevfx_centos:centos7

ARG http
ARG https

ENV http_proxy=$http
ENV https_proxy=$https

RUN yum update -y && yum install -y \
    nano \
    csh \
    libXp \
    libXmu \
    libXpm \
    libXi \
    libtiff \
    libXinerama \
    elfutils \
    gcc \
    gstreamer-plugins-base.x86_64 \
    gamin \
    git \
    scons \
    mesa-utils \
    mesa-libGL-devel \
    tcsh \
    xorg-x11-server-Xorg \
    xorg-x11-server-Xvfb \
    git \
    gcc-c++ \
    make \
    libXinerama-devel \
    libXext-devel \
    libXrandr-devel \
    libXi-devel \
    libXcursor-devel \
    libXxf86vm-devel \
    mesa-libGLU libpng12 SDL freetype2 xorg-x11-fonts* \
    vulkan-devel \
    wget && \
    yum groupinstall -y "X Window System" "Fonts"


RUN yum groupinstall -y "Development Tools"
RUN yum -y install xorg-x11-fonts*
RUN fc-cache

RUN yum -y install epel-release
# remove mirrors from epel or else it will fail if there are no mirrors
# in the country the build machine is
RUN cat /etc/yum.repos.d/epel.repo \
    | sed 's/.baseurl/baseurl/' \
    | sed 's/metalink/#metalink/' > /tmp/epel.repo && \
    /bin/mv /tmp/epel.repo /etc/yum.repos.d/epel.repo
RUN yum clean all && yum makecache
RUN yum -y install python2-scons

RUN ln -s /lib64/libbz2.so.1 /lib64/libbz2.so.1.0 ; \
    ln -s libcrypto.so.1.0.2k /usr/lib64/libcrypto.so.10 ; \
    ln -s libcrypto.so.0.9.8e /usr/lib64/libcrypto.so.6 ; \
    ln -s libssl.so.1.0.2k /usr/lib64/libssl.so.10 ; \
    ln -s libssl.so.0.9.8e /usr/lib64/libssl.so.6 ; \
    ln -s /usr/bin/ar /usr/sbin/ar

RUN fc-cache
RUN yum -y install source-highlight
RUN yum -y install ncurses ncurses-devel ncurses-static
RUN yum -y install sqlite-devel libdb-devel
RUN yum -y install gdbm-devel tkinter
RUN yum -y install libcurl-devel
RUN yum -y install mesa-libGLU-devel
RUN yum -y install dbus-devel dbus-glib-devel
RUN yum -y install cmake
RUN yum -y install yaml-cpp*
RUN yum -y install tinyxml*
RUN yum -y install xz
RUN yum -y install centos-release-scl
RUN yum -y install devtoolset-6
RUN yum -y install glibc-devel binutils

#
#	Install OSL dependencies
#
RUN	yum install -y \
		flex \
		bison
#
#	Install Qt dependencies
#
RUN	yum install -y \
		xkeyboard-config.noarch \
		fontconfig-devel.x86_64

RUN yum -y install  enca readline-devel flex-devel
#RUN yum search devtoolset
RUN yum clean all
RUN rm -rf /var/cache/yum/*

#_tkinter           bsddb185           dl
#imageop            sunaudiodev

RUN ln -s /usr/bin/ranlib /usr/sbin/ranlib

# add default to gcc 6.3.1 to /etc/bashrc, so running bash will automatically set it
# RUN printf "\nsource scl_source enable devtoolset-6\n" >> /etc/bashrc

COPY docker/run.sh /run.sh
ADD pipeline/tools/python /atomo/pipeline/tools/python
ADD pipeline/tools/config /atomo/pipeline/tools/config
COPY pipeline/build/SConstruct /atomo/pipeline/build/SConstruct

# since we're having trouble with a gcc 4.1.2 built in centos
# (link complains about code needing -fPIC, when it was compiled with it!)
# we are adopting this quick and dirty solution, using a pre-compiled binary
# of gcc 4.1.2, done in an arch linux distro!
# this binaries work without issue, not complening about -fPIC.
COPY docker/gcc-bin-4.1.2.tgz /atomo/pipeline/build/.download/4.1.2.tar.gz

# download packages so the image contain all tarballs.
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
    export TERM=xterm && \
    export ftp_proxy=$http_proxy && \
    touch /atomo/.root && \
    mkdir -p /atomo/pipeline/build/ && \
    cd /atomo/pipeline/build && \
    env && \
    PYTHONPATH=/atomo/pipeline/tools/python scons download -j $(( $(grep MHz /proc/cpuinfo | wc -l) * 2 ))

# to avoid clashing in osl
RUN yum -y remove boost

# we need this to build python3
RUN yum -y install libffi-devel tcl-devel tk-devel libXt-devel
RUN yum -y install gcc-objc++

# and we need this for qt 5.x
RUN yum -y install xcb-util-wm-devel libxcb-devel.x86_64 \
    xcb-util-image-devel.x86_64 xcb-util-keysyms-devel.x86_64 \
    xcb-util-renderutil-devel.x86_64 xcb-util-wm-devel.x86_64
    
RUN yum -y install xcb*devel libXcursor-devel \
    libXrandr-devel \
    libXinerama-devel \
    libXi-devel \
    mesa-libGLU-devel \

RUN ln -s /lib64/libssl.so /lib64/libssl.so.10 && \
    ln -s /lib64/libcrypto.so /lib64/libcrypto.so.10 && \
    ln -s /lib64/libtinfo.so.6 /lib64/libtinfo.so.5 && \
    ln -s /lib64/libnsl.so.2 /lib64/libnsl.so.1 \


ENTRYPOINT "/run.sh"
