#PBS -N fastqc
#PBS -l nodes=1:ppn=8,vmem=16gb,walltime=150:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load FastQC/0.11.2

i=1

until [ $i == 6 ]
do
  cd dataset$i
  fastqc *.fastq -t 12
  i=$(( i+1 ))
  cd ..
done
