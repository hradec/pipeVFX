#!/bin/bash  



h=$(head -2 license.txt | tail -1  | sed 's/#//')
echo $h
l=$(cat license.txt | wc -l)
find ./pipeline/tools/ -type f -name "*.py"  | grep -v gdata | while read a ; do
    x=$(head -1 $a)
    export f=0
    if [ "${x:0:3}" == "#!/" ] ; then
        echo $x > /tmp/file
        export f=1
    else
        touch /tmp/file
    fi
    
    cat license.txt >> /tmp/file
    
    x=$(grep "$h" $a)
    if [ "$x" == "" ] ; then
        echo $f $a
        tail -n  $(expr $(cat $a | wc -l) - $f) $a >> /tmp/file
    else
        echo "$f grep '$h' $a"
        tail -n  $(expr $(cat $a | wc -l) - $l - $f) $a >> /tmp/file
    fi 
    mv /tmp/file $a 
done