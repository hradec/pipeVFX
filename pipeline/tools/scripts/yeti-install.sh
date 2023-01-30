#!/bin/bash

tools=$(dirname $(dirname $(readlink -f $BASH_SOURCE)))
export PYTHONPATH=$tools/python/
CD=$(pwd)
rm -rf /dev/shm/yeti-install
mkdir -p /dev/shm/yeti-install/
cd /dev/shm/yeti-install/
echo "Downloading..."
root=$(/bin/python2 -c "import pipe;print '%s/yeti/' % pipe.roots.apps()")
curl -L 'https://peregrinelabs.com/pages/yeti-download'  \
	| grep Linux -B50 \
	| grep -v License \
	| grep Yeti.v \
	| awk -F'"' '{print $4}' \
	| grep linux.tar \
	| sort -r | uniq \
	| while read url ; do
		version=$(echo $url | awk -F'/' '{print $(NF-1)}')
		maya_version=$(echo $url | awk -F'Maya' '{print $(NF)}' | awk -F'-' '{print $1}')
		echo "Yeti $version / maya $maya_version"
		if [ ! -e $root/$version/$maya_version ] ; then
			curl -L $url | tar xzf -
			sudo mkdir -p $root/$version/
			if [ $(echo $version | awk -F'.' '{print $1}') -le 3 ] ; then
				sudo mkdir -p $root/$version/$maya_version/
				sudo mv * $root/$version/$maya_version/
			else
				folder=$(ls -1)
				sudo mv $folder $root/$version/$maya_version
			fi
		else
			echo "this version is already installed."
			echo $root/$version/$maya_version
			sudo chmod a+rx -R $root/$version/$maya_version
		fi
done
cd $CD
#rm -rf /dev/shm/yeti-install
echo "Done!"
