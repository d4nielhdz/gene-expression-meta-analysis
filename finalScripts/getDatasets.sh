#PBS -N get_datasets
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=550:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

module load sratoolkit/2.9.6

i=1
# define n to be the number of datasets + 1
n=8 

until [ $i == $n ]
do
    # create n dataset directories to download the files in
    mkdir dataset$i
    cd dataset$i
    # iterarting through each .u2f (url to filename) file
    # where entries are separated by commas
    # first column is the URL of the organism
    # second column is the filename with which it will be stored
    for line in $(cat ../ds$i.u2f)
    do 
        # getting URL
        url=$(echo $line | awk -F, '{print $1}')
        # getting filename
        filename=$(echo $line | awk -F, '{print $2}')
        # downloading
        wget $url -O $filename
        # converting to fastq
        fasterq-dump $filename -e 12 -t /scratch
        # gzipping
        gzip $filename
    done
    i=$(( i+1 ))
    cd ..
done
