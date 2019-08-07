#PBS -N compression
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

i=1

until [ $i == 8 ]
  do
  cd dataset$i 
  if [ $i == 2 ] || [ $i == 6 ]
    then
    i=$(( i+1 ))
    continue
  fi
  for file in dataset$i/*fastq
    do
    gzip $file
  done
  i=$(( i+1 ))
  cd ..
done