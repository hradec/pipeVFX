#!/bin/bash
# we use find first to just chmod the files/folders that need it
# ideally, we would prefer to use inotify to receive events when files
# are writen in specific folders, but that doesnt work over NFS.
# inotify only work with disk filesystem, so it needs to run on the actual
# NFS server.
# this pulling method can run in a docker container, in a client machine
STUDIO=frankbarton

if [ "$(pgrep -fa chmod)" == "" ] ; then
    python -c 'print("="*120)'
    date
    python -c 'print("="*120)'

    # mode  2777 = rwxrwsrwx (s on group)
    # mode 00777 = rwxrwxrwx and clears sSt

    #chmod 2777 -R /$STUDIO/jobs/*/*/*/users/MAC/
    find /$STUDIO/apps/*/*/*            \! -perm 0555 -type d -exec chmod 00555 -v {} \;

    #chmod 2777 -R /$STUDIO/jobs/*/*/*/users/MAC/
    find /$STUDIO/jobs/*/*/*/users/MAC/ \! -perm a+rwx -type d -exec chmod 00777 -v {} \;
    # we made all user folders writable since covid!
    find /$STUDIO/jobs/*/*/*/users/     \! -perm a+rwx -type d -exec chmod 00777 -v {} \;

    #chmod a+rwx -R /$STUDIO/jobs/*/*/*/published/
    find /$STUDIO/jobs/*/*/*/published/ \! -perm a+rwx  -exec chmod 00777 -v {} \;
    #chmod a+rwx -R /$STUDIO/jobs/*/SAIDAS/
    find /$STUDIO/jobs/*/SAIDAS/        \! -perm a+rwx  -exec chmod 00777 -v {} \;
    #chmod a+rwx -R /$STUDIO/jobs/*/ARTWORKS/
    find /$STUDIO/jobs/*/ARTWORKS/      \! -perm a+rwx  -exec chmod 00777 -v {} \;
    #chmod a+rwx -R /$STUDIO/jobs/*/OFFLINE_XML/
    find /$STUDIO/jobs/*/OFFLINE_XML/   \! -perm a+rwx  -exec chmod 00777 -v {} \;
    #chmod a+rwx -R /$STUDIO/jobs/*/PRODUCAO/
    find /$STUDIO/jobs/*/PRODUCAO/      \! -perm a+rwx  -exec chmod 00777 -v {} \;

    echo "$(date) - Done"
fi
