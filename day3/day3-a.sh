#!/bin/bash
set -eo pipefail

IFS=','

read -r -a array <<< `cat input.in | head -n1`
read -r -a array2 <<< `cat input.in | head -n2 | tail -n1`

dist=100000000
posx=0
posy=0
declare -A mat1
declare -A mat2

for elem in "${array[@]}"
do
    smjer=${elem:0:1}
    broj=${elem:1:100}
    dx=0
    dy=0
    if [ $smjer = "R" ]; then
        dy=1
    elif [ $smjer = "L" ]; then
        #posx=$($pos)
        dy=-1
    elif [ $smjer = "U" ]; then
        dx=-1
    elif [ $smjer = "D" ]; then
        dx=1
    else 
        echo "ERROR"
        exit 1
    fi
    for ((i=0; i < $broj; ++i)) 
    do
        posx=$(($posx+$dx))
        posy=$(($posy+$dy))
        mat1[$posx,$posy]=1;
    done
done
posx=0
posy=0
for elem in "${array2[@]}"
do

    smjer=${elem:0:1}
    broj=${elem:1:100}
    dx=0
    dy=0
    if [ $smjer = "R" ]; then
        dy=1
    elif [ $smjer = "L" ]; then
        dy=-1
    elif [ $smjer = "U" ]; then
        dx=-1
    elif [ $smjer = "D" ]; then
        dx=1
    else 
        echo "ERROR"
        exit 1
    fi
    for (( i=0; i < $broj; ++i )) 
    do
        posx=$(($posx+$dx))
        posy=$(($posy+$dy))
        #printf "%s. (%s,%s)\n" $i $posx $posy
        if ! [ -v ${mat1[$posx,$posy]} ]; then
            echo "Found"
            newX=$posx
            newY=$posy
            if [ $posx -lt 0 ]; then
                newX=$((-$posx))
            fi
            if [ $posy -lt 0 ]; then
                newY=$((-$posy))
            fi
            newD=$(($newX+$newY))
            echo $newD
            if [ $dist -ge $newD ]; then
                dist=$newD
            fi
        #else 
            #echo "not found"
        fi
    done
done
echo $dist
