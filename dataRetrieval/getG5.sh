#PBS -N convert_2fa
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR
module load sratoolkit/2.9.6

cd dataset5
for line in $(cat ../sraUrls/ds5.u2f)
  do
  url=$(echo $line | awk -F, '{print $1}')
        # getting filename
        filename=$(echo $line | awk -F, '{print $2}')
        # downloading
        wget $url -O $filename
        fasterq-dump $filename -e 12 -t /scratch
done

find *fastq > d5.fqs

for line in $(cat d5.fqs)
  do
  gzip $line
done