#PBS -N run_kallisto
#PBS -l nodes=1:ppn=8,vmem=20gb,mem=16gb,walltime=150:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load kallisto/0.44.0

# building indices
# using 31 kmer size
# building indices
# using 31 kmer size
find d*_transcriptome.fa* | parallel --max-args 1 -j+8 -I%\
 kallisto index -i %.idx %


i=6
# define n to be the number of datasets + 1
n=7
# moving index files to their respective dataset directories
until [ $i == $n ]
  do
# wildcard used because file extension may not be the same for all transcriptomes
  mv d${i}_transcriptome*.idx dataset${i}/.
  i=$(( i+1 ))
done

i=6
# kallisto quant
until [ $i == $n ]
  do

  cd dataset$i
  indexFile=$(ls -1 d${i}_transcriptome*.idx)
  # checking if sequences are single end
  if [ `ls -1 *.sra.fastq.gz | wc -l ` -gt 0 ]
    then
    for file in $(find *.sra.fastq.gz)
      do
      kallisto quant  -i $indexFile -o $file_out --single\
      -- -l 200 -t 8 -b 30 $file
    done
  else
    for file in $(find d$i_*_1.fastq.gz_t | sed 's/.sra_1.fastq.gz_t//')
      do
      kallisto quant\
      -i $indexFile\
      -o ${file}_out -t 8 -b 30\
      $file.sra_1.fastq.gz_t $file.sra_2.fastq.gz_t
    done
  fi

  i=$(( i+1 ))

  cd ..

done