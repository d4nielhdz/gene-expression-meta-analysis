#PBS -N concat_files
#PBS -q default
#PBS -l nodes=1:ppn=8,vmem=20gb,mem=16gb,walltime=150:00:00
#PBS -V

cd $PBS_O_WORKDIR


i=1
n=8

until [ $i == $n ]
do
  cat d${i}*.split >> d${i}_concat.tsv
  i=$(( i+1 ))
done
