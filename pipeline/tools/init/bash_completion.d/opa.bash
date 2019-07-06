#!/bin/sh


_opa_cache(){
    cache="/usr/tmp/bash_completion_opa_$USER.cache"
#    pipeName=$( echo $ROOT | rev | cut -d'/' -f1 | rev )
    if [ ! -f $cache ] || [  $(expr $(date +%s) - 60) -gt $(stat -c %Y $cache) ] ; then
        /atomo/pipeline/tools/scripts/run opa 2>&1 | grep -v ERROR | grep "$pipeName" > $cache
    fi
    echo $cache
}

_opa(){
    cache=$(_opa_cache)
    local cur
    cur="$2"
    if type opa >&/dev/null; then
            COMPREPLY=( "${COMPREPLY[@]}" $(
            compgen -W "$( \
                cat $cache  \
            | sort -u )" -- "$cur" ) )
    fi
}
#_op

complete -o bashdefault -o default -o nospace -F _opa opa 2>/dev/null \
	|| complete -o default -o nospace -F _opa opa


