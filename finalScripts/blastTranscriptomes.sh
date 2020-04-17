#PBS -N transcriptome_blast
#PBS -q default
#PBS -l nodes=1:ppn=8,vmem=20gb,mem=16gb,walltime=150:00:00
#PBS -V

cd $PBS_O_WORKDIR

module load seqkit/2018
module load ncbi-blast+/2.2.31

export BLASTDB="/data/secuencias/uniprotkb/uniprot_sprot"

for transcriptome in d*transcriptome.fa
  do
  seqkit split $transcriptome -s 1000
  for chunk in ${transcriptome}.split/*
  do
    blastx\
    -db $BLASTDB\
    -query $chunk\
    -num_threads 18\
    -max_target_seqs 5\
    -outfmt 6\
    -evalue 1e-5\
    -out ${chunk}.out
  done
done
