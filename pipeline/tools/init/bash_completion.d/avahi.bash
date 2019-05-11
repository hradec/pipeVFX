#!/bin/sh

#rm -rf $cache
_avahi_cache(){
    cache="/usr/tmp/bash_completion_avahi_$USER.cache"
    if type avahi-browse >&/dev/null; then
        if [ -n "$(pidof avahi-daemon)" ]; then
            if [ ! -f $cache ] || [  $(expr $(date +%s) - 200) -gt $(stat -c %Y $cache) ] ; then
                avahi-browse -at > $cache
            fi
        fi
    fi
    echo $cache
}

_avahi_ping(){
    cache=$(_avahi_cache)
    local cur
    cur=$2
    #  of the service, and if it contains ";", it may mistify
    #  the result. But on Gentoo (at least), -k isn't available
    #  (even if mentioned in the manpage), so...
    if type avahi-browse >&/dev/null ; then
        COMPREPLY=( "${COMPREPLY[@]}" $(
        compgen -W "$( cat $cache \
            | egrep 'Micro|Workstation|_switch._tcp' \
            | grep -v 'vmnet' \
            | cut -d' ' -f6 \
            | sort -u \
            | sed 's/$/.local/g' \
        )" -- "$cur" ) )
    fi
}
complete -o bashdefault -o default -o nospace -F _avahi_ping ping 2>/dev/null \
	|| complete -o default -o nospace -F _avahi_ping ping 


_avahi_ssh(){
    cache=$(_avahi_cache)
    local cur
    cur=$( echo $2 | cut -d'@' -f2)
    cur2=$2
    #  of the service, and if it contains ";", it may mistify
    #  the result. But on Gentoo (at least), -k isn't available
    #  (even if mentioned in the manpage), so...
    if type avahi-browse >&/dev/null ; then
        COMPREPLY=( "${COMPREPLY[@]}" $(
        compgen -W "$( cat $cache \
            | egrep 'SSH' \
            | grep -v 'vmnet' \
            | cut -d' ' -f6 \
            | sort -u \
            | sed 's/$/.local/g' \
        )" -- "$cur" ) )
    fi
}
complete -o bashdefault -o default -o nospace -F _avahi_ssh ssh 2>/dev/null \
	|| complete -o default -o nospace -F _avahi_ssh ssh 

