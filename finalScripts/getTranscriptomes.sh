#PBS -N get_transcriptomes
#PBS -l nodes=1:ppn=8,vmem=16gb,walltime=150:00:00
#PBS -q default
#PBS -V

cd $PBS_O_WORKDIR

i=1

for line in $(cat transcriptomes.u2f)
  do
  # getting URL
  url=$(echo $line | awk -F, '{print $1}')
  # getting filename
  filename=$(echo $line | awk -F, '{print $2}')
  # downloading
  echo wget $url -O $filename
  # checking if file needs to be unzipped
  if [ -f d${i}_transcriptome.*bz2 ]
    then
    echo bunzip2 -d $filename
  fi
  i=$(( i+1 ))
done