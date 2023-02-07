#!/bin/bash


python -c 'print("="*120)'
date
python -c 'print("="*120)'

tools=$(dirname $(dirname $(readlink -f $BASH_SOURCE)))
export PYTHONPATH=$tools/python/
CD=$(pwd)
rm -rf  /dev/shm/chrome-install/
mkdir -p /dev/shm/chrome-install/
cd /dev/shm/chrome-install/

echo "Downloading latest chrome..."
curl -L -O 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' || exit -2
echo "uncompressing..."
ar x google-chrome-stable_current_amd64.deb
sleep 1
xz -d data.tar.xz
tar xf data.tar
if [ ! -e ./opt/google/chrome/google-chrome ] ; then
    ls -l
    echo "ERROR - couldnt find chrome after uncompressing... something is wrong!!"
    exit -4
fi
version=$(./opt/google/chrome/google-chrome --version | awk '{print $(NF)}')
chrome_root=$(python2 -c "import pipe;print '%s/chrome/' % pipe.roots.apps()")
echo "Detected version $version..."
if [ ! -e $chrome_root/$version/google-chrome ] ; then
    echo "Installing since it's a new version..."
    sudo mkdir -p $chrome_root/$version
    sudo rsync -avpP ./opt/google/chrome/* $chrome_root/${version}/
    sudo chown root:artists -R $chrome_root/$version
    sudo chmod 00755 -R $chrome_root/$version
    echo "Finished installing chrome version $version to $chrome_root/${version}/"
else
    echo "this version is already installed."
    echo $chrome_root/$version
fi
cd $CD
rm -rf /dev/shm/chrome-install
echo "Done!"
