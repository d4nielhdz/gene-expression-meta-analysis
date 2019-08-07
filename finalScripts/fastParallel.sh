#PBS -N fastparallel
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR
module load fastp/0.20


i=1

# define n to be the number of datasets + 1
n=8

until [ $i == $n ]
  do
  
  
  cd dataset$i
  # checking if sequences are single end
  if [ `ls -1 *.sra.fastq.gz | wc -l ` -gt 0 ]
    then
    find d$i_*.fastq.gz |  parallel --max-args 1 -j+8 -I%\
    fastp -i % -o %_t\
    -5 -3 -q 30 -t 1 -f 1\
    --unpaired1 %_up\
    --failed_out %_fail_reasons
  else
    find d$i_*_1.fastq.gz | sed 's/.sra_1.fastq.gz//' | parallel --max-args 1 -j+8 -I%\
    fastp -i %.sra_1.fastq.gz -o %.sra_1.fastq.gz_t\
    -I %.sra_2.fastq.gz -O %.sra_2.fastq.gz_t\
    -5 -3 -q 30 -t 1 -f 1\
    --unpaired1 %.sra_1.fastq.gz_up\
    --unpaired2 %.sra_2.fastq.gz_up\
    --failed_out %_fail_reasons
  fi
  cd ..
  i=$(( i+1 ))
done
