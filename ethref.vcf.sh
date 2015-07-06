#!/bin/bash

if [ $# -lt 4 ] ; then
   echo "Not enough arguments! Specify 4 arguments."
   echo "Usage: sh ethref.vcf.sh [input_vcf] [genome_ver (hg19)] [snpeff_loc] [out_name]"
   exit 1
fi
if [ $# -gt 4 ] ; then
   echo "Too many arguments! Specify 4 arguments."
   echo "Usage: sh ethref.vcf.sh [input_vcf] [genome_ver (hg19)] [snpeff_loc] [out_name]"
   exit 1
fi

in_vcf=$1
ref_DB=$2
snpeff_loc=$3
out_name=$4

T_1=$(date +%s)
#========================================================
#Analyze .vcf
#========================================================

echo "\n\n"
echo "============================================="
echo "(1/3) Annotate variants using snpEff"
echo "============================================="

PROGNAME=$(java -Xmx24g -jar $snpeff_loc'snpEff.jar' -v -c $snpeff_loc'snpEff.config' $ref_DB $in_vcf > $out_name'.snpeff.vcf')
T_2=$(date +%s)
T_DIFF=$(($T_2-$T_1))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(2/3) Create a report in tab-delimited format"
echo "============================================="

PROGNAME=$(python python/makereport.py $out_name'.snpeff.vcf' > $out_name'.report.txt') 
T_3=$(date +%s)
T_DIFF=$(($T_3-$T_2))
echo "It took $T_DIFF seconds."

echo "\n\n"
echo "============================================="
echo "(3/3) Compare sample data to Haplotype Data. Pick Ethnicity Choice"
echo "============================================="

CHOICE=$(python python/APchoice.py $in_vcf ref/hapdata.popstats.txt $out_name.pop.txt)
echo "wrote results to $out_name.pop.txt"

sh ref/customize.sh $CHOICE
echo "generated custom genome for $CHOICE"

T_4=$(date +%s)
T_DIFF=$(($T_4-$T_3))
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
