#PBS -N get_genomes
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load sratoolkit/2.9.6
cd dataset2
# iterarting through each .u2f (url to filename) file
# where entries are separated by commas
# first column is the URL of the organism
# second column is the filename with which it will be stored
for line in $(cat ../sraUrls/ds2fix.u2f)
do 
    # getting URL
    url=$(echo $line | awk -F, '{print $1}')
    # getting filename
    filename=$(echo $line | awk -F, '{print $2}')
    # downloading
    wget $url -O $filename
    fasterq-dump $filename -e 12 -t /scratch
    gzip $filename
done