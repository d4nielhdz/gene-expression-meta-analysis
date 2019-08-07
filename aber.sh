if [ `ls -1 multi* | wc -l ` -gt 0 ]
	then
	echo file exists
else
	echo it does not	
fi
