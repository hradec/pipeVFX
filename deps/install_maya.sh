#!/bin/bash
#
# use this script to build all libraries used by pipeVFX, with all versions
#
m2016url='http://download.autodesk.com/us/support/files/maya_2016_ext2/Autodesk_Maya_2016_EXT2_SP1_EN_Linux_64bit.tgz?_ga=2.4471354.825751166.1551409050-743188725.1550459149'
m2016md5='aaa'

m2019url='https://trial2.autodesk.com/NetSWDLD/2019/MAYA/EC2C6A7B-1F1B-4522-0054-4FF79B4B73B5/ESD/Autodesk_Maya_2019_Linux_64bit.tgz'
m2019md5='c1b7481b240da05e9b1626ac5003d151'

createRun(){
  cat > /tmp/maya.sh << EOF
#!/bin/bash
install(){
  md5=\$(md5sum /atomo/deps/\$(basename \$1) 2>/dev/null | awk '{print \$1}')
  if [ "\$md5" != "\$2" ] ; then
      rm -rf /atomo/deps/\$(basename \$1)
  fi
  if [ ! -e /atomo/deps/\$(basename \$1) ] ; then
    echo "Downloading..."
    curl -o /atomo/deps/\$(basename \$1) "\$1"
  fi
  echo "Installing..."
  mkdir /tmp/\$3
  cd /tmp/\$3
  tar xf /atomo/deps/\$(basename \$1)

  # maya
  ./setup

  # arnold
  # ./unix_installer.sh
}
install "\$1" "\$2" "\$3"
EOF
  chmod a+rwx /tmp/maya.sh
  echo -e "#!/bin/bash\nwhile true ; do sleep 1 ; echo . ; done" > /tmp/run.sh
  chmod a+rwx /tmp/run.sh
}
CD=$(readlink -f $(dirname $BASH_SOURCE)/../)
# docker build $CD/docker/ -t hradec/pipevfx_centos_base:centos7

__install(){
  createRun
  echo "$1" "$2" "$3"
  docker stop pipevfx_install_maya
  docker rm pipevfx_install_maya
  docker run --name pipevfx_install_maya -d \
    -v $CD/:/atomo/ \
    -v /tmp/maya.sh:/maya.sh \
    -v /tmp/run.sh:/run.sh \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e QT_GRAPHICSSYSTEM=opengl -e QT_X11_NO_MITSHM=1 \
    -e DISPLAY=$DISPLAY \
    --entrypoint /run.sh \
  hradec/pipevfx_centos_base:centos7

  docker exec -ti pipevfx_install_maya /bin/sh /maya.sh "$1" "$2" "$3"

  # echo > /tmp/rsync.sh
  # docker container diff pipevfx_install_maya | egrep 'var|etc|opt|usr' | \
  # awk '{print $(NF)}' | while read p ; do
  #   echo "[ -f '$p' ] && mkdir -p '/atomo/apps/linux/x86_64/maya/$3/$(dirname $p)' && rsync -ah '$p' 'atomo/apps/linux/x86_64/maya/$3/$p' &" >> /tmp/rsync.sh
  # done
  # chmod a+rwx /tmp/rsync.sh
  # docker cp /tmp/rsync.sh pipevfx_install_maya:/rsync.sh
  # docker exec -i pipevfx_install_maya /bin/sh /rsync.sh

  docker stop pipevfx_install_maya
}


__install "$m2019url" "$m2019md5" 2019
# install "$m2016url" "$m2016md5" 2016.21
