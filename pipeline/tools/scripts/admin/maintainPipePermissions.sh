#!/bin/bash
# we use find first to just chmod the files/folders that need it
# ideally, we would prefer to use inotify to receive events when files
# are writen in specific folders, but that doesnt work over NFS.
# inotify only work with disk filesystem, so it needs to run on the actual
# NFS server.
# this pulling method can run in a docker container, in a client machine
tools=$(dirname $(dirname $(dirname $(readlink -f $BASH_SOURCE))))
export PYTHONPATH=$tools/python/
CD=$(pwd)
ps=$(pgrep -fa bash.*maintainPipePermissions.sh | grep -v grep | grep -v $$ | wc -l)
lock=$(pgrep -fa find | grep -v grep)

STUDIO=$(python2 -c "import pipe,os;print os.path.abspath('%s/../../' % pipe.roots.tools()).strip('/')")
# ps -AHfc
# pgrep -fa bash.*maintainJobPermissions.sh | grep -v $$
# pgrep -fa bash.*maintainJobPermissions.sh | grep -v $$ | wc -l
# echo $$
# echo "[$chmod]" "[$ps]"

doit() {
    # fix permissions for tools folders
    find /$STUDIO/pipeline/tools/               \! -perm 00755 -exec chmod 00755 {} \;
    find /$STUDIO/pipeline/tools/               \! -group artists -exec chown root:artists {} \;
    find /$STUDIO/pipeline/tools/               \! -user  root    -exec chown root:artists {} \;

    # fix permissions for apps folders
    find /$STUDIO/apps/*/*/                \! -perm 00755    -exec chmod 00755 -v {} \;
    find /$STUDIO/apps/*/*/                \! -group artists -exec chown root:artists {} \;
    find /$STUDIO/apps/*/*/                \! -user  root    -exec chown root:artists {} \;
}

if [ "$lock" == "" ] && [ $ps -lt 2 ] ; then
    python -c 'print("="*120)'
    date
    echo "ps find:[$lock]" "ps maintainJobPermissions.sh:[$ps]"
    python -c 'print("="*120)'

    time doit
    echo "$(date) - Done"
fi
