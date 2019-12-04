#!/bin/bash
set -euo pipefail

fun() {
    num=$1
    br=11
    cnt=0
    ok=0
    while [ $num -gt 0 ]; do
        last=$(($num%10))
        if [ $br -eq $last ]; then
            cnt=$(($cnt+1))
        else 
            if [ $cnt -eq 2 ]; then
                ok=1
                
            fi
            cnt=1
        fi
        if [ $br -lt $last ]; then
            echo "0"
            return
        fi
        br=$last
        num=$((num/10))
    done
    if [ $cnt -eq 2 ] || [ $ok -eq 1 ]; then
        echo "1"
    else 
        echo "0"
    fi
}

(
for ((c=137683; c<=596253; ++c ))
do
    echo $(fun $c)
done
) | awk '{sum+=$1} END {print sum}'

