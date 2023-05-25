#! /usr/bin/bash
fastqc first_ecoli.fastq.gz
minimap2 -d target.mmi ref_ecoli.fna
minimap2 -a target.mmi first_ecoli.fastq.gz > output.sam
samtools view -bo output.bam output.sam
samtools flagstat output.bam > output.txt
bash parsing.bash
samtools sort output.bam -o output.sorted.bam
freebayes -f ref_ecoli.fna output.sorted.bam > result.vcf
echo Finished