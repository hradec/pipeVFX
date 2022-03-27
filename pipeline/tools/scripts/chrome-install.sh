#!/bin/bash

tools=$(dirname $(dirname $(readlink -f $BASH_SOURCE)))
export PYTHONPATH=$tools/python/
CD=$(pwd)
mkdir -p /dev/shm/chrome-install/
cd /dev/shm/chrome-install/
echo "Downloading latest chrome..."
curl -L -O 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' || exit -2
echo "uncompressing..."
ar x google-chrome-stable_current_amd64.deb
tar xf data.tar.xz
if [ ! -e ./opt/google/chrome/google-chrome ] ; then
    echo "ERROR - couldnt find chrome after uncompressing... something is wrong!!"
    exit -4
fi
version=$(./opt/google/chrome/google-chrome --version | awk '{print $(NF)}')
chrome_root=$(/bin/python2 -c "import pipe;print '%s/chrome/' % pipe.roots.apps()")
echo "Detected version $version..."
if [ ! -e $chrome_root/$version ] ; then
    echo "Installing since it's a new version..."
    sudo mkdir -p $chrome_root/$version
    sudo rsync -avpP ./opt/google/chrome/* $chrome_root/${version}/
    sudo chown root:artists -R $chrome_root/$version
    echo "Finished installing chrome version $version to $chrome_root/${version}/"
else
    echo "this version is already installed."
    echo $chrome_root/$version
fi
cd $CD
rm -rf /dev/shm/chrome-install
echo "Done!"
