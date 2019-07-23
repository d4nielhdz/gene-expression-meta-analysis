    #PBS -N download_missing
    #PBS -l nodes=1:ppn=16,mem=16gb,vmem=32gb,walltime=250:00:00
    #PBS -q default
    #PBS -V

    cd $PBS_O_WORKDIR


i=1
# getting URL
until [ $i == 5 ]
do
  cd dataset$i
  for line in $(cat ../missing$i.txt)
  do
  url=$(echo $line | awk -F, '{print $1}')
  # getting filename
  filename=$(echo $line | awk -F, '{print $2}')
  # downloading
  wget $url -O $filename
  echo "Downloading $filename from $url"
  done
  i=$(( i+1 ))
  cd ..
done
