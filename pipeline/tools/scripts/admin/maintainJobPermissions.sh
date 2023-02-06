#!/bin/bash
# we use find first to just chmod the files/folders that need it
# ideally, we would prefer to use inotify to receive events when files
# are writen in specific folders, but that doesnt work over NFS.
# inotify only work with disk filesystem, so it needs to run on the actual
# NFS server.
# this pulling method can run in a docker container, in a client machine
STUDIO=frankbarton

if [ "$(pgrep -fa find.*chmod)" == "" ] ; then
    python -c 'print("="*120)'
    date
    python -c 'print("="*120)'

    # mode  2777 = rwxrwsrwx (s on group)
    # mode 00777 = rwxrwxrwx and clears sSt

    #chmod 2777 -R /$STUDIO/jobs/*/*/*/users/MAC/
    find /$STUDIO/jobs/*/*/*/users/MAC/ \! -perm a+rwx -type d -exec chmod 00777 -v {} \;

    # we made all user folders writable since covid!
    # find /$STUDIO/jobs/*/*/*/users/     \! -perm a+rwx -type d -exec chmod 00777 -v {} \;

    # fix permissions for tools folders
    find /$STUDIO/pipeline/tools/               \! -perm 00755 -type d -exec chmod 00755 -v {} \;
    find /$STUDIO/jobs/*/*/*/users/*/tools/     \! -perm 00755 -type d -exec chmod 00755 -v {} \;

    # fix permissions for apps folders
    find /$STUDIO/apps/*/*/                \! -perm 00755 -type d -exec chmod 00755 -v {} \;
    find /$STUDIO/apps/*/*/                \! -group artists -exec chown root:artists {} \;
    find /$STUDIO/apps/*/*/                \! -user  root    -exec chown root:artists {} \;

    #chmod a+rwx -R /$STUDIO/jobs/*/*/*/published/
    find /$STUDIO/jobs/*/*/*/published/ \! -perm a+rwx  -exec chmod 00777 -v {} \;

    ls -d /$STUDIO/jobs/*/* | egrep '[A-Z]' | while read path ; do
        #chmod a+rwx -R $path
        find $path        \! -perm a+rwx  -exec chmod 00777 -v {} \;
    done

    echo "$(date) - Done"
fi
