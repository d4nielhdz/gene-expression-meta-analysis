#!/bin/zsh


getReverse() { echo ${1%%1.fastq}"2.fastq" }

find ../raw_data/d2_f1*_1.fastq | env_parallel -I% echo "hey" >> $( getReverse % )

