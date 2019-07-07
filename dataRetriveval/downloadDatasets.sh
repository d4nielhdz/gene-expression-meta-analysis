#PBS -N kallisto_quan
#PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
#PBS -q default
#PBS -V

i=1

until [ $i == 6 ]
do
    # create 5 dataset directories to download the files in
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
    done
    i=$(( i+1 ))
    cd ..
done
