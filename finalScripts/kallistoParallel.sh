#PBS -N concat_files
#PBS -q default
#PBS -l nodes=1:ppn=8,vmem=20gb,mem=16gb,walltime=150:00:00
#PBS -V

cd $PBS_O_WORKDIR


i=1
n=8

until [ $i == $n ]
do
  if [ -d d${i}*gz*split ]
  then
    cd d${i}_transcriptome.fa.gz.split
  else
    cd d${i}_transcriptome.fa.split
  fi
  cat *.out >> d${i}_concat.tsv
  i=$(( i+1 ))
  cd ..
done
