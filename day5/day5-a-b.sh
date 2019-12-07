#!/bin/bash

set -exuo pipefail

INPUT="input.in"
IFS=','

read -r -a array <<< `cat $INPUT`


pos=0
len=$(echo "${#array[@]}")
echo $len

while [ $pos -lt $len ]; do
     comm=$(printf "%05d" ${array[$pos]})
     opcode=${comm:3:2}
     if [ $opcode -eq 99 ]; then
         break
     fi
     firstType=${comm:2:1}
          first=${array[$(($pos+1))]}
          if [ $opcode -eq 01 ] || [ $opcode -eq 02 ] || [ $opcode -eq 07 ] || [ $opcode -eq 08 ] || [ $opcode -eq 05 ]  || [ $opcode -eq 06 ]; then
         secondType=${comm:1:1}
         thirdType=${comm:0:1}
         second=${array[$(($pos+2))]}
         third=${array[$(($pos+3))]}

         if [ $firstType -eq 1 ]; then 
             firstVal=$first
         else 
             firstVal=${array[$first]}
         fi
         if [ $secondType -eq 1 ]; then
             secondVal=$second
         else 
             secondVal=${array[$second]}
         fi
         if [ $opcode -eq 01 ]; then 
             res=$(($firstVal+$secondVal))
         elif [ $opcode -eq 02 ]; then 
             res=$(($firstVal*$secondVal))
         elif [ $opcode -eq 07 ]; then
             if [ $firstVal -lt $secondVal ]; then
                 res=1
             else 
                 res=0
             fi
         elif [ $opcode -eq 08 ]; then
             if [ $firstVal -eq $secondVal ]; then
                 res=1
             else
                 res=0
             fi
         elif [ $opcode -eq 05 ]; then
             if [ $firstVal -ne 0 ]; then
                 pos=$secondVal
             else 
                 pos=$(($pos+3))
             fi
             continue
         elif [ $opcode -eq 06 ]; then
             if [ $firstVal -eq 0 ]; then
                 pos=$secondVal
             else 
                 pos=$(($pos+3))
             fi
             continue
         fi
         if [ $thirdType -eq 0 ]; then
             array[$third]=$res
         else 
             array[${array[$third]}]=$res
         fi
         pos=$(($pos+4))
     elif [ $opcode -eq 03 ]; then
         if [ $firstType -eq 0 ]; then
             array[$first]=5
         else 
             array[${array[$first]}]=5
         fi
         pos=$(($pos+2))
     elif [ $opcode -eq 04 ]; then
         echo "OUT ${array[$first]}"
         pos=$(($pos+2))
     elif [ $opcode -eq 99 ]; then
         break
     else 
         echo "ERROR"
         exit 1
     fi
done
echo "----------"
echo "ID 5 : ${array[5]}"
