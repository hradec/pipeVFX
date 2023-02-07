#!/bin/bash

python -c 'print("="*120)'
date
python -c 'print("="*120)'

tools=$(dirname $(dirname $(readlink -f $BASH_SOURCE)))
export PYTHONPATH=$tools/python/
CD=$(pwd)
mkdir -p /dev/shm/blender-install/
cd /dev/shm/blender-install/
echo "Downloading latest blender..."
curl -k -s -L 'https://download.blender.org/release/' \
    | sed -e 's/\r//g' -e 's/<\/a//g' \
    | awk -F'>' '{print $2$3}' \
    | awk '{print $2" "$1}' \
    | grep -i blender \
    | sort -t'-' -k3n -k2M -k1n \
    | grep 202. | grep -v Benchmark \
    | sort -k2V \
    | tail -5 \
    | awk '{print $(NF)}' | egrep '\/$' \
    | while read p ; do
        echo "Listing https://download.blender.org/release/$p"
        curl -k -s -L "https://download.blender.org/release/$p" \
            | sed -e 's/\r//g' -e 's/<\/a//g' \
            | awk -F'>' '{print $2$3}' \
            | awk '{print $2" "$1}' \
            | sort -t'-' -k3n -k2M -k1 \
            | awk '{print $(NF)}' | egrep 'linux.*\.tar\.' \
            | while read fileName ; do
                folder=$(echo $fileName | awk -F'.tar' '{print $1}')
                version=$(echo $fileName | awk -F'-' '{print $2}')
                blender_root=$(python2 -c "import pipe;print '%s/blender/' % pipe.roots.apps()")
                if [ ! -e $blender_root/$version/blender ] ; then
                    rm -rf ./*
                    echo "Downloading and uncompressing $fileName..."
                    curl -k -L "https://download.blender.org/release/$p/$fileName" | tar xJf -
                    find ./ -type f -name blender | while read p ; do
                        for version in $($p --version | grep Blender | awk '{print $2}') ; do
                            if [ ! -e $blender_root/$version/blender ] ; then
                                folder=$(dirname $p)
                                echo "Installing at $folder since $version it's a new version..."
                                sudo rm -rf $blender_root/$version
                                sudo mv $folder $blender_root/${version}
                                sudo chmod 0755 $blender_root/$version
                                sudo chown root:artists -R $blender_root/$version
                                # fix permissions on some packages that have broken ones
                                find $blender_root/$version/ -perm /u=x -exec chmod a+x {} \;
                                find $blender_root/$version/ -perm /u=r -exec chmod a+r {} \;
                                echo "Finished installing blender version $version to $blender_root/${version}/"
                            else
                                echo -n $chrome_root/$version
                                echo ": this version is already installed."
                            fi
                        done
                    done
                else
                    echo -n $chrome_root/$version
                    echo ": this version is already installed."
                fi
                python2 -c 'print "="*80'
            done
    done
cd $CD
# rm -rf /dev/shm/blender-install
echo "Done!"

# version=$(./opt/google/chrome/google-chrome --version | awk '{print $(NF)}')
# chrome_root=$(python2 -c "import pipe;print '%s/chrome/' % pipe.roots.apps()")
# echo "Detected version $version..."
# if [ ! -e $chrome_root/$version ] ; then
#     echo "Installing since it's a new version..."
#     sudo mkdir -p $chrome_root/$version
#     sudo rsync -avpP ./opt/google/chrome/* $chrome_root/${version}/
#     sudo chown root:artists -R $chrome_root/$version
#     echo "Finished installing chrome version $version to $chrome_root/${version}/"
# else
#     echo "this version is already installed."
#     echo $chrome_root/$version
# fi
# cd $CD
# rm -rf /dev/shm/chrome-install
# echo "Done!"
