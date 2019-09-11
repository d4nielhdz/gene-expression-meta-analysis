#PBS -N zip_missing
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=550:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load sratoolkit/2.9.6

cd dataset6

for file in $(cat ../mz.txt)
  do
  fasterq-dump $file -e 12 -t /scratch
done

for file in $(find *.fastq)
    do
    gzip $file
done


