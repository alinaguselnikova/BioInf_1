params.seq = "/root/Downloads/first_ecoli.fastq.gz"
params.ref = "/root/Downloads/ref_ecoli.fna"

process algorithm {
    input:
	path seq
	path ref
    output:
	stdout
    
    """
#! /usr/bin/bash
fastqc $seq
minimap2 -d target.mmi $ref
minimap2 -a target.mmi $seq > output.sam
samtools view -bo output.bam output.sam
samtools flagstat output.bam > output.txt
IFS=\$'.' var=(\$(awk -F'mapped [(]|[)]' '{print \$2}' output.txt))
echo "\$var"
if ((\$var > 90));
then
	echo OK
	samtools sort output.bam -o output.sorted.bam
	samtools index output.bam
	freebayes -f $ref output.sorted.bam > result.vcf
	echo Finished


else 
	echo Not OK
fi
    """
}



workflow {
	def param = Channel.fromPath(params.seq)
	algorithm(param, params.ref)| view {it.trim()}
}

