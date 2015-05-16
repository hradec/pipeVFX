#!/bin/bash  



h=$(head -2 .license.txt | tail -1  | sed 's/#//')
echo $h
l=$(cat .license.txt | wc -l)
find ./pipeline/tools/ -type f -name "*.py"  | grep -v gdata | while read a ; do
    xx=$(head -1 $a)
    export f=0
    if [ "${xx:0:3}" == "#!/" ] ; then
        echo $xx > /tmp/file
        export f=1
    else
        touch /tmp/file
    fi
    
    cat .license.txt >> /tmp/file
    
    x=$(grep "$h" $a)
    if [ "$x" == "" ] ; then
        echo $f $a
        if [ "$f" == "0" ] ; then
            cat $a >> /tmp/file
        else
            cat $a | grep -v "$xx" >> /tmp/file
        fi
    else
        let tmp=$(cat $a | wc -l)-$l*$(grep "$h" $a | wc -l)+1-$f
        echo "$f $tmp grep '$h' $a"
        tail -n  $tmp $a >> /tmp/file
    fi 
    mv /tmp/file $a 
done