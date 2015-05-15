#!/bin/sh

name=$(basename $BASH_SOURCE)

_runLibAlias(){
    local cur
    cur=$2
    COMPREPLY=( "${COMPREPLY[@]}" $(
    compgen -W "$( alias | grep pipe.libs | cut -d' ' -f2 | cut -d= -f1 \
                    | sort -u )" -- "$cur" ) )
}


complete -o bashdefault -o default -o nospace -F _runLibAlias runlib 2>/dev/null \
	|| complete -o default -o nospace -F _runLibAlias runlib


