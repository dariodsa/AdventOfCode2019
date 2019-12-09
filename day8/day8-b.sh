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
br=0
for (( x=0; x < 6; ++x )) 
do 
    for (( y=0; y < 25; ++y )) 
    do  
        for (( i=0; i < $NUM; ++i )) 
        do 
            relative=$(($x*25+$y))
            absoultive=$(($relative+6*25*$i))
            s=${line:absoultive:1}
            if [ "$s" == "0" ]; then
                echo -n " "
                break
            elif [ "$s" == "1" ]; then 
                echo -n "*"
                break
            fi
        done
    done
    echo ""
done

