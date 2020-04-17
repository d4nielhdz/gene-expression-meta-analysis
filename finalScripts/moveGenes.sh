#!/bin/sh

i=1
n=8
until [ $i == $n ]
  do
  mkdir ../../resultData/dataset$i
  for line in $(cat ../dataRetrieval/d$i*.csv)
    do
    p1=$(echo $line | awk -F, '{print $1}')
    p2=$(echo $line | awk -F, '{print $2}')
    f1=$(echo $line | awk -F, '{print $3}')
    mv ../../resultData/$p1*_out ../../resultData/dataset$i/.
    mv ../../resultData/$p2*_out ../../resultData/dataset$i/.
    mv ../../resultData/$f1*_out ../../resultData/dataset$i/.
  done
  i=$(( i+1 ))
done


