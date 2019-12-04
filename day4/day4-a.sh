#!/bin/bash
set -euo pipefail

fun() {
    num=$1
    br=11
    er=0
    while [ $num -gt 0 ]; do
        last=$(($num%10))
        if [ $br -eq $last ]; then
            er=1
        fi
        if [ $br -eq 11 ]; then
            br=$last
        elif [ $br -lt $last ]; then
            echo "0"
            return
        fi
        br=$last
        num=$((num/10))
    done
    echo $er
}

echo $(fun 11111)
echo $(fun 122345)
echo $(fun 223450)
echo $(fun 123789)
(
for ((c=137683; c<=596253; ++c ))
do
    echo $(fun $c)
done
) | awk '{sum+=$1} END {print sum}'

