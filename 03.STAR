
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

module load star

for f in *R1.noadapt.fastq.gz; do

    r=$(sed -e "s/R1/R2/g" <<< "$f")
    s=$(cut -d. -f1 <<< "$f")

STAR \
--runThreadN 20 --genomeDir ../genome/ \
--sjdbGTFfile ../genome/Ixodes_scapularis.IscaW1.39.gtf --sjdbOverhang 149 \
--readFilesIn ${f} ${r} \
--readFilesCommand gunzip -c \
--outSAMtype BAM SortedByCoordinate \
--quantMode GeneCounts \
--outFilterMismatchNmax 5 \
--outFilterMismatchNoverReadLmax 0.02 \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFileNamePrefix ${s}_ \
--outFilterMatchNminOverLread 0 --outFilterScoreMinOverLread 0 --outFilterMatchNmin 40
done



