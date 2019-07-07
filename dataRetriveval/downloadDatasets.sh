#!/bin/sh
#PBS -N kallisto_quan
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

i=1

until [ $i==6 ]
    do
        mkdir dataset$i
        i=$(( i+1 ))
    done
