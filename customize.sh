#usage: sh customize.sh POP
POP=$1
T_START=$(date +%s)
echo "customizing hg19 with $POP"
python python//overlay.py ref/$POP'.chr1.editready.txt' ref/hg19.1.fasta > ref/$POP'.chr1.fasta'
python python//overlay.py ref/$POP'.chr2.editready.txt' ref/hg19.2.fasta > ref/$POP'.chr2.fasta'
python python//overlay.py ref/$POP'.chr3.editready.txt' ref/hg19.3.fasta > ref/$POP'.chr3.fasta'
python python//overlay.py ref/$POP'.chr4.editready.txt' ref/hg19.4.fasta > ref/$POP'.chr4.fasta'
python python//overlay.py ref/$POP'.chr5.editready.txt' ref/hg19.5.fasta > ref/$POP'.chr5.fasta'
python python//overlay.py ref/$POP'.chr6.editready.txt' ref/hg19.6.fasta > ref/$POP'.chr6.fasta'
python python//overlay.py ref/$POP'.chr7.editready.txt' ref/hg19.7.fasta > ref/$POP'.chr7.fasta'
python python//overlay.py ref/$POP'.chr8.editready.txt' ref/hg19.8.fasta > ref/$POP'.chr8.fasta'
python python//overlay.py ref/$POP'.chr9.editready.txt' ref/hg19.9.fasta > ref/$POP'.chr9.fasta'
python python//overlay.py ref/$POP'.chr10.editready.txt' ref/hg19.10.fasta > ref/$POP'.chr10.fasta'
python python//overlay.py ref/$POP'.chr11.editready.txt' ref/hg19.11.fasta > ref/$POP'.chr11.fasta'
python python//overlay.py ref/$POP'.chr12.editready.txt' ref/hg19.12.fasta > ref/$POP'.chr12.fasta'
python python//overlay.py ref/$POP'.chr13.editready.txt' ref/hg19.13.fasta > ref/$POP'.chr13.fasta'
python python//overlay.py ref/$POP'.chr14.editready.txt' ref/hg19.14.fasta > ref/$POP'.chr14.fasta'
python python//overlay.py ref/$POP'.chr15.editready.txt' ref/hg19.15.fasta > ref/$POP'.chr15.fasta'
python python//overlay.py ref/$POP'.chr16.editready.txt' ref/hg19.16.fasta > ref/$POP'.chr16.fasta'
python python//overlay.py ref/$POP'.chr17.editready.txt' ref/hg19.17.fasta > ref/$POP'.chr17.fasta'
python python//overlay.py ref/$POP'.chr18.editready.txt' ref/hg19.18.fasta > ref/$POP'.chr18.fasta'
python python//overlay.py ref/$POP'.chr19.editready.txt' ref/hg19.19.fasta > ref/$POP'.chr19.fasta'
python python//overlay.py ref/$POP'.chr20.editready.txt' ref/hg19.20.fasta > ref/$POP'.chr20.fasta'
python python//overlay.py ref/$POP'.chr21.editready.txt' ref/hg19.21.fasta > ref/$POP'.chr21.fasta'
python python//overlay.py ref/$POP'.chr22.editready.txt' ref/hg19.22.fasta > ref/$POP'.chr22.fasta'
python python//overlay.py ref/$POP'.chr23.editready.txt' ref/hg19.23.fasta > ref/$POP'.chr23.fasta'
python python//overlay.py ref/$POP'.chr24.editready.txt' ref/hg19.24.fasta > ref/$POP'.chr24.fasta'
python python//overlay.py ref/$POP'.chr25.editready.txt' ref/hg19.25.fasta > ref/$POP'.chr25.fasta'
T_END=$(date +%s)
T_DIFF=$(($T_END-$T_START))
echo "It took $T_DIFF seconds."
