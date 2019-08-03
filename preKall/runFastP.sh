#!/bin/sh

for forward in ../raw_data/d2_p*_1_fastqc.zip
  do
  reverse=${forward%%1_fastqc.zip}"2_fastqc.zip"
  echo =
  echo fastp -i $forward -o "${forward%%.zip}_t" -I $reverse -O\
  "${reverse%%.zip}_t" -5 -3 -q 25 -t 1 -f 1\
   --unpaired1 "${forward%%.zip}_up"\
    --unpaired2 "${reverse%%.zip}_up"\
  --failed_out "${forward%%.zip}_reason"
  echo =
  done


for forward in ../raw_data/d2_f1*_1_fastqc.zip
do
  reverse=${forward%%1_fastqc.zip}"2_fastqc.zip"
  # echo =
  fastp -i $forward -o "${forward%%.zip}_t"\
   -I $reverse -O "${reverse%%.zip}_t" -5 -3 -q 25 -t 1\
   -f 1 --unpaired1 "${forward%%.zip}_up"\
    --unpaired2 "${reverse%%.zip}_up"\
  --failed_out "${forward%%.zip}_reason"
  # echo =
done

find ../raw_data/d2_f1*_1_fastqc.zip | parallel

