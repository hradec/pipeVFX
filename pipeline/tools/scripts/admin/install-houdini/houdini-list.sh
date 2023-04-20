#!/bin/bash

CD=$(dirname $(readlink -f $0))
. $CD/install-puppeteer.sh

cd $CD/nodejs/
export CHROME=$CD/google-chrome



# http_proxy=$(ppython -c 'import os;print(os.environ["PIPE_PROXY_SERVER"])')
# https_proxy=$http_proxy
# ftp_proxy=$http_proxy
# extra=" --proxy '$https_proxy' "

# houdini.env contains the USERNAME and PASSWORD env vars to login at sidefx.com:
# export USERNAME=<username>
# export PASSWORD=<password>
. $CD/houdini.env
cp $CD/scrape.js ./

rm -f /tmp/scrape.log
touch /tmp/scrape.log
for n in {1..5} ; do
    if [ "$(cat /tmp/scrape.log)" == "" ] ; then
        node $extra ./scrape.js > /tmp/scrape.log
    fi
done
if [ "$(cat /tmp/scrape.log)" == "" ] ; then
    echo "cant retrieve list!!!"
    exit -1
fi

grep tar.gz /tmp/scrape.log | while read v ; do
    echo $(grep "$v" /tmp/scrape.log -B1 | head -1 | awk -F'"' '{print "https://www.sidefx.com/"$(NF-1)"get/"}') $v
done
