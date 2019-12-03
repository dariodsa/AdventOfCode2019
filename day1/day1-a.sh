#!/bin/bash
cat input.in | awk '{a=int($1/3)-2} {print a}' | awk ' {sum+=$1} END {print sum}'
