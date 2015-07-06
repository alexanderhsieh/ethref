T_START=$(date +%s)
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr1.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr1.phase1.projectConsensus.genotypes.vcf > chr1.popstats.txt
rm -f ALL.*
echo "done with chr1"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr6.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr6.phase1.projectConsensus.genotypes.vcf > chr6.popstats.txt
rm -f ALL.*
echo "done with chr6"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr2.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr2.phase1.projectConsensus.genotypes.vcf > chr2.popstats.txt
rm -f ALL.*
echo "done with chr2"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr3.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr3.phase1.projectConsensus.genotypes.vcf > chr3.popstats.txt
rm -f ALL.*
echo "done with chr3"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr4.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr4.phase1.projectConsensus.genotypes.vcf > chr4.popstats.txt
rm -f ALL.*
echo "done with chr4"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr5.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr5.phase1.projectConsensus.genotypes.vcf > chr5.popstats.txt
rm -f ALL.*
echo "done with chr5"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr7.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr7.phase1.projectConsensus.genotypes.vcf > chr7.popstats.txt
rm -f ALL.*
echo "done with chr7"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr8.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr8.phase1.projectConsensus.genotypes.vcf > chr8.popstats.txt
rm -f ALL.*
echo "done with chr8"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr9.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr9.phase1.projectConsensus.genotypes.vcf > chr9.popstats.txt
rm -f ALL.*
echo "done with chr9"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr10.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr10.phase1.projectConsensus.genotypes.vcf > chr10.popstats.txt
rm -f ALL.*
echo "done with chr10"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr11.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr11.phase1.projectConsensus.genotypes.vcf > chr11.popstats.txt
rm -f ALL.*
echo "done with chr11"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr12.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr12.phase1.projectConsensus.genotypes.vcf > chr12.popstats.txt
rm -f ALL.*
echo "done with chr12"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr13.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr13.phase1.projectConsensus.genotypes.vcf > chr13.popstats.txt
rm -f ALL.*
echo "done with chr13"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr14.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr14.phase1.projectConsensus.genotypes.vcf > chr14.popstats.txt
rm -f ALL.*
echo "done with chr14"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr15.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr15.phase1.projectConsensus.genotypes.vcf > chr15.popstats.txt
rm -f ALL.*
echo "done with chr15"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr16.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr16.phase1.projectConsensus.genotypes.vcf > chr16.popstats.txt
rm -f ALL.*
echo "done with chr16"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr17.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr17.phase1.projectConsensus.genotypes.vcf > chr17.popstats.txt
rm -f ALL.*
echo "done with chr17"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr18.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr18.phase1.projectConsensus.genotypes.vcf > chr18.popstats.txt
rm -f ALL.*
echo "done with chr18"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr19.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr19.phase1.projectConsensus.genotypes.vcf > chr19.popstats.txt
rm -f ALL.*
echo "done with chr19"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr20.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr20.phase1.projectConsensus.genotypes.vcf > chr20.popstats.txt
rm -f ALL.*
echo "done with chr20"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr21.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr21.phase1.projectConsensus.genotypes.vcf > chr21.popstats.txt
rm -f ALL.*
echo "done with chr21"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chr22.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chr22.phase1.projectConsensus.genotypes.vcf > chr22.popstats.txt
rm -f ALL.*
echo "done with chr22"
wget ftp://ftp.ncbi.nlm.nih.gov/1000genomes/ftp/release/20101123/interim_phase1_release/ALL.chrX.phase1.projectConsensus.genotypes.vcf.gz
gunzip *.gz
echo "done gunzipping"
python ../python/happarse.py ALL.chrX.phase1.projectConsensus.genotypes.vcf > chrX.popstats.txt
rm -f ALL.*
echo "done with chrX"
T_DIFF=$(($T_END-$T_START))
echo "It took $T_DIFF seconds."


