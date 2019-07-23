#PBS -N convert_missing
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

 cd $PBS_O_WORKDIR

i=1

until [ $i == 5 ]
do
  cd dataset$i
  for line in $(cat ../missing$i.txt)
  do
    filename=$(echo $line | awk -F, '{print $2}')
    echo "fasterq-dump $filename"
  done
  i=$(( i+1 ))
  cd ..
done
