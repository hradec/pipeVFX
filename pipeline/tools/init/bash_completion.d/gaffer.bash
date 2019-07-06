#!/bin/sh


#rm -rf $cache
_gaffer_cache(){
    cache="/usr/tmp/bash_completion_gaffer_$USER.cache"
#    pipeName=$( echo $ROOT | rev | cut -d'/' -f1 | rev )
    if [ ! -f $cache ] || [  $(expr $(date +%s) - 60) -gt $(stat -c %Y $cache) ] ; then
        /atomo/pipeline/tools/scripts/run gaffer -help 2>&1 | grep '^ ' | grep -v gaffer > $cache
    fi
    echo $cache
}

_gaffer(){
    cache=$(_gaffer_cache)
    local cur
    cur="$2"
    if type gaffer >&/dev/null; then
            COMPREPLY=( "${COMPREPLY[@]}" $(
            compgen -W "$( \
                cat $cache  \
            | sort -u )" -- "$cur" ) )
    fi
}

complete -o bashdefault -o default -o nospace -F _gaffer gaffer 2>/dev/null \
	|| complete -o default -o nospace -F _gaffer gaffer 


