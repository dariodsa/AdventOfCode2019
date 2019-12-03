#!/bin/bash

set -exuo pipefail

IFS=','

read -r -a array <<< `cat input.in`

pos=0
len=$(echo "${#array[@]}")
echo $len

while [ $pos -lt $len ]; do
    first=${array[$(($pos+1))]}
     second=${array[$(($pos+2))]}
     third=${array[$(($pos+3))]}
     #echo "${array[$pos]} $pos "
     if [ ${array[$pos]} -eq 1 ]; then
         array[$third]=$((${array[$first]}+${array[$second]}))
     elif [ ${array[$pos]} -eq 2 ]; then
         array[$third]=$((${array[$first]}*${array[$second]}))
     else 
         break
     fi
     pos=$(($pos+4))
done
echo "----------"
for elem in "${array[*]}"
do 
    echo $elem
done
