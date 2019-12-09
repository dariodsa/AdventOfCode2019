#!/bin/bash
set -euo pipefail

NUM=$((25*6))
INPUT='input'

line=`cat $INPUT`

len=$((${#line}))
num=$((len/NUM))
echo $num

pos=0
mini=12132123
s_mini=""
for (( i=0; i < $num; ++i )) 
do 
    s=${line:pos:NUM}
    #echo $s
    zeros=$(echo $s | awk -F0 '{printf NF-1}')
    if [ $zeros -lt $mini ]; then
        mini=$zeros
        s_mini=$s
    fi
    pos=$(($pos+$NUM))
done
echo $s_mini

one=$(echo $s_mini | awk -F1 '{printf NF-1}')
two=$(echo $s_mini  | awk -F2 '{printf NF-1}')
echo $two $one
echo $(($one*$two))

