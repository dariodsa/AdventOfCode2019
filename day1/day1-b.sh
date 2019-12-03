#!/bin/bash

getRes() {
   ans=0;
   curr=$1;
   fuel=$((curr/3-2))
   curr=$fuel
   ans=$((ans+fuel));
   while [ $fuel -gt 0 ]; do
       fuel=$((curr/3-2))
       if [ $fuel -ge 0 ]; then
           ans=$((ans+fuel))
       fi
       curr=$fuel
   done
   echo $ans
}
IFS=$'\n'
(for num in `cat input-b.in` 
do
   echo $(getRes $num)   
done
) | awk '{sum+=$1} END {print sum}'
