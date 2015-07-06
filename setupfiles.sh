T_1=$(date +%s)
cd ref
echo "========================================================"
echo "Download, parse, and remove Haplotype Files"
echo "========================================================"
sh gethapparse.sh
cat *.popstats.txt > hapdata.popstats.txt
T_2=$(date +%s)
T_DIFF=$(($T_2-$T_1))
echo "It took $T_DIFF seconds."

echo "========================================================"
echo "Download and process Reference Genome File"
echo "========================================================"
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/human_g1k_v37.fasta.gz
gunzip human_g1k_v37.fasta.gz
mv human_g1k_v37.fasta > hg19.fasta
awk '/^>/{f="hg19."++d".fasta"} {print > f}' hg19.fasta
T_3=$(date +%s)
T_DIFF=$(($T_3-$T_2))
echo "It took $T_DIFF seconds."

echo "========================================================"
echo "Download dbSNP release 137"
echo "========================================================"
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/database/snp137.txt.gz
gunzip snp137.txt.gz
T_4=$(date +%s)
T_DIFF=$(($T_4-$T_3))
echo "It took $T_DIFF seconds."

echo "========================================================"
echo "Prepare ethnicity-specific files"
echo "========================================================"
sh split.sh



#echo "========================================================"
#echo "Generate Synthetic Reference"
#echo "========================================================"
#sh customize.sh asw
#sh customize.sh ceu
#sh customize.sh chb
#sh customize.sh chd
#sh customize.sh jpt
#sh customize.sh lwk
#sh customize.sh tsi
#sh customize.sh yri
#sh customize.sh african
#sh customize.sh eastasian
#sh customize.sh european

#T_5=$(date +%s)
#T_DIFF=$(($T_5-$T_4))
#echo "It took $T_DIFF seconds."

T_6=$(date +%s)
T_DIFF=$(($T_6-$T_1))
echo "TOTAL: took $T_DIFF seconds."
