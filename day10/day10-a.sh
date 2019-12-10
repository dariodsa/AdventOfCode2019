#!/bin/bash
set -euo pipefail

INPUT="input"

declare -A array

abs() {
    if [ $1 -lt $2 ]; then 
        echo $(($2-$1))
    else
        echo $(($1-$2))
    fi
}
gcd() {
   if [ $1 -eq 0 ]; then
       echo $2
   elif [ $2 -eq 0 ]; then
       echo $1
   else
       c=$(($1%$2))
       if [ $c -gt 0 ]; then
           gcd $2 $c
       else 
           echo $2
       fi
   fi
}
it=0
for line in `cat $INPUT`
do
    len=${#line}
    for (( i=0;i<$len;++i)) 
    do 
        array[$it,$i]=${line:$i:1}
    done
    it=$((it+1))
done
rows=$(cat $INPUT | wc -l)
cols=$len

for ((x=0;x<$rows;++x))
do
    for ((y=0;y<$cols;++y))
    do
        declare -A arr
        for ((i=0;i<$rows;++i))
        do 
            for((j=0;j<$cols;++j))
            do
                arr[$i,$j]=0
            done
        done
        if [ "${array[$x,$y]}" == "." ]; then
            continue
        fi
        for ((xx=0;xx<$rows;++xx))
        do
            for ((yy=0;yy<$cols;++yy))
            do 
                if [ $xx -eq $x ] && [ $yy -eq $y ]; then
                    continue
                fi
                if [ ${array[$xx,$yy]} == "#" ]; then
                    deltax=$(abs $x $xx)
                    deltay=$(abs $y $yy)
                    gcdVal=$(gcd $deltax $deltay)
                    dx=$(($deltax/$gcdVal))
                    dy=$(($deltay/$gcdVal))
                    if [ $x -gt $xx ]; then 
                        dx=$((-$dx))
                    fi
                    if [ $y -gt $yy ]; then
                        dy=$((-$dy))
                    fi
                    #echo "$xx $yy _($dx,$dy) $gcdVal"
                    nx=$(($xx+$dx))
                    ny=$(($yy+$dy))
                    for ((k=0;k<50;++k))
                    do
                        arr[$nx,$ny]=1
                        nx=$(($nx+$dx))
                        ny=$(($ny+$dy))
                    done
                fi
            done 
        done
        asteroid=0
        for ((xx=0;xx<$rows;++xx))
        do
            for((yy=0;yy<$cols;++yy))
            do
               if  [ ${arr[$xx,$yy]} -eq 0 ] && [ ${array[$xx,$yy]} == "#" ]; then
                   #echo "$x $y => $xx $yy"
                   asteroid=$((asteroid+1))
               fi
            done
        done
        unset arr
        echo  $asteroid $x $y 

    done
done
