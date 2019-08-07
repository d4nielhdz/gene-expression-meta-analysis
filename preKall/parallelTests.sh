#PBS -N iftests
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

i=1

until [ $i == 8 ]
do
  if [ $i == 2 ] || [ $i == 4 ]
  then
    echo kk$i
  else
    echo pp$i
  fi
  i=$(( i+1 ))
done  
