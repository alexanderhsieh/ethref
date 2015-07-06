#!/bin/bash

if [ $# -lt 6 ] ; then
   echo "Not enough arguments! Specify 6 arguments."
   echo "Usage: sh ethref.bam.sh [input_bam] [ref_fasta] [genome_ver (hg19)] [samtools_loc] [snpeff_loc] [out_name]"
   exit 1
fi

if [ $# -gt 6 ] ; then
   echo "Too many arguments! Specify 6 arguments."
   echo "Usage: sh ethref.bam.sh [input_bam]  [ref_fasta] [genome_ver (hg19)] [samtools_loc] [snpeff_loc] [out_name]"
   exit 1
fi

in_bam=$1
ref_fasta=$2
ref_DB=$3
sam_loc=$4
snpeff_loc=$5
out_name=$6

T_1=$(date +%s)
#========================================================
#Convert .bam to .vcf
#========================================================

echo "\n\n"
echo "============================================="
echo "(1/7) Sort the BAM file using samtools"
echo "============================================="

PROGNAME=$($sam_loc/samtools sort $in_bam $out_name'.sorted')
T_2=$(date +%s)
T_DIFF=$(($T_2-$T_1))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(2/7) Index BAM file using samtools"
echo "============================================="

PROGNAME=$($sam_loc/samtools index $out_name'.sorted.bam')
T_3=$(date +%s)
T_DIFF=$(($T_3-$T_2))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(3/7) Call variants using samtools"
echo "============================================="

PROGNAME=$($sam_loc/samtools mpileup -uf $ref_fasta $out_name'.sorted.bam' | $sam_loc/bcftools/bcftools view -vcg -> $out_name'.vcf')
T_4=$(date +%s)
T_DIFF=$(($T_4-$T_3))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(4/7) Map variants to dbSNP version 137 to assign rs ID"
echo "============================================="

PROGNAME=$(python python/mapper.py ref/snp137.txt $out_name'.vcf' $out_name'.rsmapped.vcf')
T_5=$(date +%s)
T_DIFF=$(($T_5-$T_4))
echo "It took $T_DIFF seconds."

#========================================================
#Analyze .vcf
#========================================================

echo "\n\n"
echo "============================================="
echo "(5/7) Annotate variants using snpEff"
echo "============================================="

PROGNAME=$(java -Xmx24g -jar $snpeff_loc'snpEff.jar' -v -c $snpeff_loc'snpEff.config' $ref_DB $out_name'.vcf' > $out_name'.snpeff.vcf')
T_6=$(date +%s)
T_DIFF=$(($T_6-$T_5))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(6/7) Create a report in tab-delimited format"
echo "============================================="

PROGNAME=$(python python/makereport.py $out_name'.snpeff.vcf' > $out_name'.report.txt')
T_7=$(date +%s)
T_DIFF=$(($T_7-$T_6))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(7/7) Compare sample data to Haplotype Data. Pick Ethnicity Choice"
echo "============================================="

CHOICE=$(python python/APchoice.py $in_vcf ref/hapdata.popstats.txt $out_name.pop.txt)
sh ref/customize.sh $CHOICE
echo "generated custom genome for $CHOICE"

T_8=$(date +%s)
T_DIFF=$(($T_8-$T_7))
echo "It took $T_DIFF seconds."

T_END=$(date +%s)
T_DIFF=$(($T_END-$T_1))
echo "Total: $T_DIFF seconds."

# Reference: This was copied from <http://www.linuxcommand.org/wss0150.php>
#PROGNAME=$(basename $0)
function error_exit{
    echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
    exit 1
}

#PROGNAME=$(some_command) 
#echo error_exit "$LINENO: An error has occurred."



