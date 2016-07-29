#!/bin/bash

w='echo -e "$(for each in a b c d e f g h i j k l m ; do ls /dev/sd$each* | head -1 ; done 2>/dev/null)" | while read d ; do echo -e "---------------------------------------------------------------------------\n# 1 $d\n  =============" ; smartctl -a  $d | egrep "# |Power_On|Reallocated_Sector" | grep -v ATTR | head -10 ; done'

echo $w
watch -n 30 $w

