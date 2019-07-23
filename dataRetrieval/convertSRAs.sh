#PBS -N dataset_download
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

# cd $PBS_O_WORKDIR

i=1

until [ $i == 6 ]
do
  for line in $(cat ds$i.u2f)
  do
    filename=$(echo $line | awk -F, '{print $2}')
    echo "fasterq-dump $filename -O dataset$i"
  done
  i=$(( i+1 ))
done
