#!/bin/sh



if [ "$(pgrep -fa bin.lightdm)" != "" ] ; then
  if [ "$(pgrep -fa x11vnc)" != "" ] ; then
    systemctl stop x11vnc
    systemctl start x11vnc
  fi
fi
