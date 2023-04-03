#!/bin/bash

unset DISPLAY
python -c 'print("="*120)'
echo "$(basename $0) - $(date)"
python -c 'print("="*120)'

tools=$(dirname $(dirname $(dirname $(readlink -f $BASH_SOURCE))))
export PYTHONPATH=$tools/python/
CD=$(pwd)

keentools_root=$(python2 -c "import pipe;print '%s/keentools/' % pipe.roots.apps()")
chrome_root=$(python2 -c "import pipe;print '%s/chrome/' % pipe.roots.apps()")
#agent='--user-agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36"'
chrome="$chrome_root/$(ls -1 $chrome_root/ | sort -V | grep -v current | tail -1)/google-chrome  --no-sandbox --headless --ignore-certificate-errors --run-all-compositor-stages-before-draw --virtual-time-budget=1000000 $agent --dump-dom  "

temp=$keentools_root/.install
mkdir -p $temp/
cd $temp/

while [ "$latest_version" == "" ] ; do
    echo .
    sleep 1
    echo  "$chrome 'https://keentools.io/download/plugins-for-nuke' 2>&1"
    page=$(eval "$chrome 'https://keentools.io/download/plugins-for-nuke' 2>&1")

    latest_version=$(echo "$page" \
        | grep 'Released on' \
        | grep -v night \
        | awk -F'>' '{print $(NF-1)}' \
        | awk -F'<' '{print $1}' \
        | sort -V \
        | tail -1 \
        | sed 's/\./_/g' \
    )
#    latest_front_page=$(curl -k -L 'https://keentools.io/' | grep -i latest.release | awk -F'>AE</span>' '{print $2}' | awk '{print $1}')

    [ "$latest_version" == "" ] && echo "$page" | grep 'Released on' \
        | grep -v night \
        | awk -F'>' '{print $(NF-1)}' \
        | awk -F'<' '{print $1}' \
        | sort -V | tail -1 \
        | sed 's/\./_/g'
    echo "[$latest_version]"
done
#echo curl -k -L -O "https://downloads.keentools.io/keentools-$latest_version-for-nuke-12_0-linux"
# curl -k -L -O "https://downloads.keentools.io/keentools-$latest_version-for-nuke-12_0-linux"

for link in $(echo "$page" | grep 'title..Download KeenTools package for Nuke' | grep data.download | awk -F'"' '{print $2}') ; do
    file=$(echo $link | awk -F'/' '{print $(NF)}')
    kversion=$(echo $file | awk -F'-' '{print $2}' | sed 's/_/./g')
    nversion=$(echo $file | awk -F'-' '{print $(NF-1)}' | sed 's/_/./g')
    f=$temp/$kversion/$nversion
    echo $f
    mkdir -p $f
    cd $f
    curl -k -L -C - "$(echo "$link" | sed 's/linux/windows/')" -o $(echo "$file" | sed 's/linux/windows/').zip
    curl -k -L -C - "$link" -o $file.zip
    unzip -o $file.zip
    rsync -avpP $temp/$kversion/ $keentools_root/$kversion/
done
#
# export v=$(echo $(curl -k -L 'https://www.foundry.com/products/nuke-family/try-nuke' | grep -i 'current version' | awk -F':' '{print $2}' | awk -F'<' '{print $1}'))
# export x=$(echo "$before_versions" | tail -1 | awk '{print $2}')
# latest_version=$v
# latest_url=$(python -c "v='$v';x='$x';x=x.split('/');print('/'.join(x[:-2]+[v,x[-1].replace(x[-2],v)]))")
#
# download() {
#     version=$1
#     link=$2
#     if [ "$(ls $keentools_root/$version/Nuke* 2>/dev/null)" == "" ] ; then
#         echo "Downloading nuke $version..."
#         mkdir -p $temp/$version
#         cd $temp/$version
#         curl -k -L -C - "$link" --output $temp/$version/nuke.tgz
#         (tar xvzf $(ls  $temp/$version/*.tgz) \
#             && sh $(ls  $temp/$version/*.run) --prefix ./ --accept-foundry-eula \
#             && mv  $temp/$version/Nuke$version $keentools_root/$version \
#             && rm  $temp/$version/*.run \
#             && rm  $temp/$version/*.tgz \
#             && rm -rf  $temp/$version/Nuke$version \
#             && cd $temp  && rm -rf $temp/$version \
#         ) || echo "ERROR: downloading nuke $version!!!"
#     else
#         echo "Not downloading nuke $version... its already installed!"
#     fi
# }
#
# i=0
# echo -e "$before_versions\n$latest_version $latest_url" | while read line ; do
#     version=$(echo $line | awk '{print $1}')
#     link=$(echo $line | awk '{print $2}')
#     download $version $link #& (( ++i % 4 )) || wait
# done
