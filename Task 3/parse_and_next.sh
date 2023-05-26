#! /usr/bin/bash
IFS=$'.' var=($(awk -F'mapped [(]|[)]' '{print $2}' output.txt))
echo "$var"
if (($var > 90));
then
	echo OK
	samtools sort output.bam -o output.sorted.bam
	samtools index output.bam
	freebayes -f ref_ecoli.fna output.sorted.bam > result.vcf
	echo Finished
else 
	echo Not OK
fi