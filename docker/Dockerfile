FROM centos:centos7

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


RUN yum group install -y "Development Tools"
RUN yum -y install xorg-x11-fonts*
RUN fc-cache

RUN yum -y install epel-release && yum -y install python2-scons

RUN ln -s /lib64/libbz2.so.1 /lib64/libbz2.so.1.0 ; \
    ln -s libcrypto.so.1.0.2k /usr/lib64/libcrypto.so.10 ; \
    ln -s libcrypto.so.0.9.8e /usr/lib64/libcrypto.so.6 ; \
    ln -s libssl.so.1.0.2k /usr/lib64/libssl.so.10 ; \
    ln -s libssl.so.0.9.8e /usr/lib64/libssl.so.6

RUN fc-cache
RUN yum clean all
RUN rm -rf /var/cache/yum/*
