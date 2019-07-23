#PBS -N multiqc
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

 cd $PBS_O_WORKDIR

multiqc dataset1/*.fastq dataset2/*.fastq dataset3/*.fastq dataset4/*.fastq dataset5/*.fastq