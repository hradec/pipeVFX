#!/bin/bash


python -c 'print("="*120)'
echo "$(basename $0) - $(date)"
python -c 'print("="*120)'

tools=$(dirname $(dirname $(dirname $(readlink -f $BASH_SOURCE))))
export PYTHONPATH=$tools/python/
CD=$(pwd)

nuke_root=$(python2 -c "import pipe;print '%s/nuke/' % pipe.roots.apps()")
chrome_root=$(python2 -c "import pipe;print '%s/chrome/' % pipe.roots.apps()")

temp=$nuke_root/.nuke-install
mkdir -p $temp/
cd $temp/



latest_version=$(echo $(curl -k -L 'https://www.foundry.com/products/nuke-family/try-nuke' | grep -i 'current version' | awk -F':' '{print $2}' | awk -F'<' '{print $1}'))
before_versions=$($chrome_root/$(ls -1 $chrome_root/ | sort -V | grep -v current | tail -1)/google-chrome --no-sandbox --headless --user-agent='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.93 Safari/537.36' --dump-dom 'https://support.foundry.com/hc/en-us/articles/360019296599-Q100600-Downloading-a-previous-version-of-Nuke' 2>/dev/null \
    | grep linux | while read l ; do echo $l | sed 's/ /\n/g' | grep linux.x86 | awk -F'"' '{print $2}' ; done \
    | sort -h | while read link ; do \
        echo $(echo $link | awk -F'/' '{print $(NF-1)}') $link ; \
    done \
    | sort -V \
| tail -40)


download() {
    version=$1
    link=$2
    if [ "$(ls $nuke_root/$version/Nuke* 2>/dev/null)" == "" ] ; then
        echo "Downloading nuke $version..."
        mkdir -p $temp/$version
        cd $temp/$version
        curl -k -L -C - "$link" --output $temp/$version/nuke.tgz
        (tar xvzf $(ls  $temp/$version/*.tgz) \
            && sh $(ls  $temp/$version/*.run) --prefix ./ --accept-foundry-eula \
            && mv  $temp/$version/Nuke$version $nuke_root/$version \
            && rm  $temp/$version/*.run \
            && rm  $temp/$version/*.tgz \
            && rm -rf  $temp/$version/Nuke$version \
            && cd $temp  && rm -rf $temp/$version \
        ) || echo "ERROR: downloading nuke $version!!!"
    else
        echo "Not downloading nuke $version... its already installed!"
    fi
}

i=0
echo -e "$before_versions\n$latest_version" | while read line ; do
    version=$(echo $line | awk '{print $1}')
    link=$(echo $line | awk '{print $2}')
    download $version $link #& (( ++i % 4 )) || wait
done
