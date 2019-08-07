#PBS -N run_kallisto
#PBS -l nodes=1:ppn=8,vmem=16gb,walltime=150:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load kallisto/0.44.0

# building indices
# using 31 kmer size
find d*_transcriptome.fa* | parallel --max-args 1 -j+8 -I%\
echo kallisto index -i % %.idx

i=1
# define n to be the number of datasets + 1
n=7
# moving index files to their respective dataset directories
until [ $i == $n ]
  do
  if [ $i == 5 ] || [ $i == 6 ]
    then
    i=$(( i+1 ))
    continue
  fi
# wildcard used because file extension may not be the same for all transcriptomes
  echo mv d${i}_transcriptome*.idx dataset${i}/.
  i=$(( i+1 ))
done

i=1
# kallisto quant
until [ $i == $n ]
  do
  
  if [ $i == 5 ] || [ $i ==6 ]
    then
    i=$(( i+1 )) 
    continue
  fi

  cd dataset$i
  # checking if sequences are single end
  if [ `ls -1 *.sra.fastq.gz | wc -l ` -gt 0 ]
    then
    find d$i_*.fastq.gz_t | parallel --max-args 1 -j+8 -I%\
    echo kallisto quant -i d${i}_transcriptome*.idx -o %_out\
    -- -l 200 -t 2 -b 30 %
  else
    find d$i_*_1.fastq.gz_t | sed 's/.sra_1.fastq.gz_t//' | parallel\
    --max-args 1 -I% -j+8 echo kallisto quant -i d${i}_transcriptome*.idx\
    -o %_out -t 2 -b 30 %.sra_1.fastq.gz_t %.sra_2.fastq.gz_t
  fi
 
  i=$(( i+1 ))

  cd ..

done