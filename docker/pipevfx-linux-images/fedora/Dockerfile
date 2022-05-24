# =================================================================================
#    This file is part of pipeVFX.
#
#    pipeVFX is a software system initally authored back in 2006 and currently
#    developed by Roberto Hradec - https://bitbucket.org/robertohradec/pipevfx
#
#    pipeVFX is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    pipeVFX is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with pipeVFX.  If not, see <http://www.gnu.org/licenses/>.
# =================================================================================

FROM fedora:35

ARG http
ARG https
ARG CUDA_URL='https://developer.download.nvidia.com/compute/cuda/11.6.1/local_installers/cuda_11.6.1_510.47.03_linux.run'

ENV http_proxy=$http
ENV https_proxy=$https


# turn the docker image into a full flag fedora workstation image
RUN dnf -y update
RUN dnf -y install systemd grub2
RUN dnf -y group install "Fedora Workstation" "Development and Creative Workstation"

# atom repository
RUN mkdir -p /tmp/.disk2/run/lock/subsys/ ; \
    rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey ; \
    echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/yum.repos.d/atom.repo ;\

# rpmfusion repository
RUN dnf install -y \
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# ==============================================================================
# install everything we need to run 3rd party software
# ==============================================================================
RUN dnf install -y \
        google-chrome-stable.x86_64 \
        xorg-x11-fonts-ISO8859-1-100dpi \
        xorg-x11-fonts-ISO8859-1-75dpi \
        liberation-mono-fonts \
        liberation-fonts-common \
        liberation-sans-fonts \
        liberation-serif-fonts \
        libXmu libXt libXi libXinerama libxcb tcsh \
        audiofile audiofile-devel \
        libpng15  \
        audiofile audiofile-devel e2fsprogs-libs libpng12 \
        x11vnc xrdp mesa-libGLw mesa-libGLU libXp \
        VirtualGL \
        gnome-tweaks libglvnd-devel cronie \
        gnome-extensions-app \
        python2 \
        autofs \
        xpra \
        sssd sssd-tools oddjob-mkhomedir \
        openssh nbd tftp rclone \
        ffmpeg ffmpeg-devel \
        vlc vlc-python \
        atom \
        dkms \
        avahi avahi-tools \
        sssd sssd-tools  oddjob-mkhomedir \
        gobject-introspection-devel cairo-gobject-devel dbus-devel

RUN python2 -m ensurepip && \
    pip2 install PyGObject dbus-python

# we don't want a ramdisk tmp folder.
RUN systemctl mask tmp.mount

# install docker
RUN dnf -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine || true
RUN dnf -y install dnf-plugins-core && \
    dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo && \
    dnf -y install docker-ce docker-ce-cli containerd.io

# ==============================================================================
# damn NVIDIA
# ==============================================================================
# cuda
# RUN curl -L -O "$CUDA_URL"
# RUN chmod a+x ./$(basename $CUDA_URL)
# RUN sh ./$(basename $CUDA_URL) --toolkit --samples --silent
# RUN rm ./$(basename $CUDA_URL)
#
# # driver
# RUN curl -L -O  https:$(curl -L https://www.nvidia.com$(curl -L $(curl -L 'https://www.nvidia.com/en-us/drivers/unix/' | grep 'Latest Production Branch' | head -1 | awk -F'"' '{print $2}') | egrep 'href.*NVIDIA-Linux-x86_64' | awk -F'"' '{print $2}') | grep 'href.*NVIDIA-Linux-x86_64' | awk -F'"' '{print $2}')
# RUN ls -1 ./NVIDIA-Lin*  | sort -V | tail -n 1 | while read p ; do chmod a+x $p ; done
# RUN ls -1 /usr/src/kernels | while read k ; do \
#             sh $(ls -1 ./NVIDIA-Lin* | sort -V | tail -n 1)  \
#             -a  -s  --no-abi-note  --ui=none -j 4 \
#             --no-x-check \
#             --force-libglx-indirect \
#             --dkms \
#             --skip-depmod \
#             --no-nouveau-check \
#             --no-x-check \
#             --kernel-name $k \
#             --kernel-source-path=/usr/src/kernels/$k ; \
#     done

# install nvidia using repository
RUN dnf -y install akmod-nvidia \
    dnf -y install xorg-x11-drv-nvidia-cuda \
    dnf -y install vdpauinfo libva-vdpau-driver libva-utils ;\

# rebuild antyhing needed using dkms
RUN ls -1 /usr/src/kernels | while read k ; do dkms autoinstall -k $k --kernelsourcedir /usr/src/kernels/$k ; depmod -a $k ; done

# patch it
COPY patches/* /

# ==============================================================================
# ldap setup
# ==============================================================================
# configure ldap on fedora
RUN chown -R root:root /etc/sssd ; chmod 600 -R /etc/sssd
RUN sssctl config-check
RUN systemctl enable sssd

# select ldap autentication
RUN authselect select sssd

# use sudoers from ldap
#RUN echo "sudoers:    files sss" >> /etc/nsswitch.conf

# configure automatic home folder creation
RUN echo "session optional pam_oddjob_mkhomedir.so skel=/etc/skel/ umask=0022" >> /etc/pam.d/system-auth
RUN systemctl enable  oddjobd

# ==============================================================================
# fix gdm login
# ==============================================================================
RUN if [ "$(grep 'IncludeAll.false' /etc/gdm/custom.conf)" == "" ] ; then \
        echo "[greeter]"        | sudo tee -a /etc/gdm/custom.conf ;\
        echo "IncludeAll=false" | sudo tee -a /etc/gdm/custom.conf ;\
    fi
# RUN sudo xhost +SI:localuser:gdm
RUN sudo -u gdm gsettings set org.gnome.login-screen disable-user-list true
# RUN sudo -u gdm gsettings get org.gnome.login-screen disable-user-list

# ==============================================================================
# create symlinks to fix missing libraries
# ==============================================================================
RUN ln -s /lib64/libssl.so /lib64/libssl.so.10
RUN ln -s /lib64/libcrypto.so /lib64/libcrypto.so.10

# ==============================================================================
# build up2date dracut initrd files, for any hardware, that have
# network boot support, including NBD
# ==============================================================================
RUN dracut -fNv --regenerate-all
