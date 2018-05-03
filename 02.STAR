
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
--readFilesIn fastq/R_S79_R1_001.fastq.gz fastq//R_S79_R2_001.fastq.gz \
--outSAMtype BAM SortedByCoordinate \
--quantMode GeneCounts \
--readFilesCommand zcat
