#PBS -N trimmo_ch
#PBS -l nodes=1:ppn=8,vmem=16gb,walltime=150:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load Trimmomatic/0.32

java -jar /data/software/Trimmomatic-0.32/trimmomatic-0.32.jar PE -phred33 chilt_40_1_1.fastq.gz chilt_40_1_2.fastq.
gz chilt_40_1_F_P.fastq chilt_40_1_F_U.fastq chilt_40_1_R_P.fastq chilt_40_1_R_U.fastq\
 ILLUMINACLIP:TrueSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:70