#!/bin/bash

set -euo pipefail

fun() {
    IFS=','

    read -r -a array <<< `cat input.in`
 
    pos=0
    len=$(echo "${#array[@]}")
    array[1]=$1
    array[2]=$2

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
    if [ ${array[0]} -eq 19690720 ]; then
        echo 1
    else 
       echo 0
    fi
}
for ((i=0; i <= 99; ++i)) 
do
    for ((j=0; j <= 99; ++j)) 
    do
        val=$(fun $i $j)
        if [ $val -eq 1 ]; then
            echo "$i $j" 
            exit 0
        fi
    done
done
echo "NEMA"
