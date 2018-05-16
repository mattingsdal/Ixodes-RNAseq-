
## get genome fasta and annotations from ensembl
## 
## ftp://ftp.ensemblgenomes.org/pub/metazoa/release-39/fasta/ixodes_scapularis/dna/
## ftp://ftp.ensemblgenomes.org/pub/metazoa/release-39/gtf/ixodes_scapularis/

# make index
STAR \
--runThreadN 4 \
--runMode genomeGenerate \
--genomeDir genome/ \
--genomeFastaFiles genome/Ixodes_scapularis.IscaW1.dna.toplevel.fa \
--sjdbGTFfile genome/Ixodes_scapularis.IscaW1.39.gtf \
--sjdbOverhang 149 \
--genomeChrBinNbits 10



## make loop for every paired read
STAR \
--runThreadN 12 --genomeDir genome/ \
--sjdbGTFfile genome/Ixodes_scapularis.IscaW1.39.gtf --sjdbOverhang 149 \
--readFilesIn fastq/A.R1.noadapt.fastq.gz fastq//A.R2.noadapt.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--quantMode GeneCounts \
--outFilterMismatchNmax 9 \
--outFilterMismatchNoverReadLmax 0.03 \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFileNamePrefix mis9 \
--readFilesCommand zcat
