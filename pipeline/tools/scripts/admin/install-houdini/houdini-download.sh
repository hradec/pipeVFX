#!/bin/bash

CD=$(dirname $(readlink -f $0))
export PATH=$CD:$PATH

# http_proxy=$(ppython -c 'import os;print(os.environ["PIPE_PROXY_SERVER"])')
# https_proxy=$http_proxy
# ftp_proxy=$http_proxy
PWD=$(pwd)

folder=$(echo $2 | sed 's/.tar.gz//')
version=$(echo $2 | awk -F'-' '{print $2}')

if [ ! -e "$3/$version/bin/houdini" ] ; then
	if [ ! -e $folder/houdini.install ] ; then

		rm -f /dev/shm/houdini.cookie
		# login to sidefx website
		if [ ! -e /dev/shm/houdini.cookie ] ; then
			# houdini.env contains the USERNAME and PASSWORD env vars to login at sidefx.com
			# export USERNAME=<username>
			# export PASSWORD=<password>
			. $CD/houdini.env
			csrf=$(curl -c /dev/shm/houdini.cookie   'https://www.sidefx.com/login/' | grep csrf | awk -F'"' '{print $(NF-1)}' | tail -1)
			login="username=$USERNAME&password=$PASSWORD&csrfmiddlewaretoken=$csrf"
			echo $login
			sleep 1
			curl -X POST -d "$login"  -b /dev/shm/houdini.cookie -c /dev/shm/houdini.cookie  --referer 'https://www.sidefx.com/login/' 'https://www.sidefx.com/login/' > /tmp/xx.html
		fi

		curl -b /dev/shm/houdini.cookie   -L "$1" | tar xvzf -
	fi

	cd ./$folder && \
	yes | ./houdini.install $(./houdini.install --accept-EULA | grep 'e.g.' | sed 's/e.g..//') \
		--install-houdini \
		--install-engine-maya \
		--install-engine-unreal \
		--install-engine-unity \
		--no-install-menus \
		--no-install-bin-symlink \
		--no-install-hfs-symlink \
		--no-install-license \
		--no-install-avahi \
		--install-sidefxlabs \
		--no-install-hqueue-server \
		--auto-install \
		--make-dir \
		--no-root-check \
		--sidefxlabs-dir "$3/$version/" "$3/$version/"
	# mkdir -p  "$3/$version/engine/maya/" && \
	# cd  "$3/$version/engine/maya/" && \
	# tar xf $PWD/engine_maya.tar.gz && \
	# mkdir -p  "$3/$version/engine/unreal/" && \
	# cd  "$3/$version/engine/unreal/" && \
	# tar xf $PWD/engine_unreal.tar.gz && \
	# mkdir -p  "$3/$version/engine/unity/" && \
	# cd  "$3/$version/engine/unity/" && \
	# tar xf $PWD/engine_unity.tar.gz
	# cd ../../
	# rm -rf ./$2
fi
