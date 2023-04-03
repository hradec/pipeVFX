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

ps=$(pgrep -fa bash.*maintainJobPermissions.sh | grep -v grep | grep -v $$ | wc -l)
lock=$(pgrep -fa 'find.*jobs' | grep -v grep)

STUDIO=$(python2 -c "import pipe,os;print os.path.abspath('%s/../../' % pipe.roots.tools()).strip('/')")
# ps -AHfc
# pgrep -fa bash.*maintainJobPermissions.sh | grep -v $$
# pgrep -fa bash.*maintainJobPermissions.sh | grep -v $$ | wc -l
# echo $$
if [ $ps -lt 2 ] ; then
    python -c 'print("="*120)'
    date
    echo "ps find:[$lock]" "ps maintainJobPermissions.sh:[$ps]"
    python -c 'print("="*120)'

    doit() {
        # mode  2777 = rwxrwsrwx (s on group)
        # mode 00777 = rwxrwxrwx and clears sSt

        # user paths
        ls -d /$STUDIO/jobs/*/* | egrep '[A-Z]' | while read path ; do
            find $path        \! -perm 00777 -exec chmod 00777 -v {} \;
        done &
        find /$STUDIO/jobs/*/*/*/users/*/tools/ \! -perm 00755  -exec chmod 00755 {} \; &
        find /$STUDIO/jobs/*/*/*/users/MAC/     \! -perm 00777  -exec chmod 00777 -v {} \; &
        find /$STUDIO/jobs/*/*/*/published/     \! -perm 00777  -exec chmod 00777 -v {} \; &
        # we made all user folders writable since covid!
        if [ "$STUDIO" == "atomo" ] ; then
            find /$STUDIO/jobs/*/*/*/users/     \! -perm a+rwx \! -path '*/tools/*'  \! -path '*/tools' -type d -exec chmod 00777 -v {} \; &
        fi
        wait
    }
    time doit

    echo "$(date) - Done"
fi
