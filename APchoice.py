'''
Created on Jun 3, 2013

@author: ALEX

Script to compare genotype of vcf file entries to the allele frequencies of different populations
Informed by haplotype data from 1000 Genomes 
Output is either Asian, African, or European
'''
import sys
import math
import time
import operator
#read each snp from sample .rsmapped.vcf, compare to hapdata.popstats.txt and pick winner
#.popstats.txt - 0=rsID, 1=asw, 2=ceu, 3=chb, 4=jpt, 5=lwk, 6=tsi, 7=yri
#.rsmapped.vcf - 0=chr, 1=pos, 2=rsID, 3=ref, 4=alt, 5=qual, 6=filt, 7=info, 8=format, 9=genotype
#f1 = .rsmapped.vcf ; f2= .popstats.txt
def choose(f1, f2, oname):
    #stime = time.time()
    #read in sample snps
    snps = dict()
    with open(f1, 'r') as f1:
        for line in f1:
            if not line.startswith("#"):
                tmp = line.split()
                snp = tmp[2]
                gt = tmp[9].split(":")[0]
                val = 0.0
                if gt == "0/1" or "1/0":
                    val = 0.5
                if gt == "1/1":
                    val = 1.0
                if gt == "0/0":
                    val = 0.0
                snps.update({snp:val})
    f1.close()
    time1 = time.time()
    #print 'done reading snps and genotypes'
    #print "took "+str(time1-stime)+" seconds"
    #read through popstats file
    aswcount = 0
    ceucount = 0
    chbcount = 0
    jptcount = 0
    lwkcount = 0
    tsicount = 0
    yricount = 0
    with open(f2,'r') as f2:
        for line in f2:
            if not line.startswith("#"):
                curr = line.split("\t")
                if curr[0] in snps:
                    gold = snps[curr[0]]
                    best = 1.0
                    for j in xrange(1,7):
                        #if closest to the "gold" value:
                        if math.fabs(float(curr[j])-float(gold)) < best:
                            best = math.fabs(float(curr[j])-float(gold))
                            win = j
                    #add prob to score
                    bonus = float(curr[j])
                    if win == 1:
                        aswcount = aswcount+1
                    if win == 2:
                        ceucount = ceucount+1
                    if win == 3:
                        chbcount = chbcount+1
                    if win == 4:
                        jptcount = jptcount+1
                    if win == 5:
                        lwkcount = lwkcount+1
                    if win == 6:
                        tsicount = tsicount+1
                    if win == 7:
                        yricount = yricount+1
    f2.close()
    #time2 = time.time()
    sum = aswcount+ceucount+chbcount+jptcount+lwkcount+tsicount+yricount
    #print 'done updating population win counts'
    #print "took "+str(time2-stime)+" seconds"
    pop = dict()
    pop.update({'asw':aswcount})
    pop.update({'ceu':ceucount})
    pop.update({'chb':chbcount})
    pop.update({'jpt':jptcount})
    pop.update({'lwk':lwkcount})
    pop.update({'tsi':tsicount})
    pop.update({'yri':yricount})
    asi = ['chb','jpt']
    afr = ['asw','lwk','yri']
    eur = ['ceu','tsi']
    out = open(oname,'w')
    #print winner
    winner = max(pop, key=pop.get)
    if winner in asi:
        print "eastasian"
        out.write("##eastasian"+"\n")
    if winner in afr:
        print "african"
        out.write("##african"+"\n")
    if winner in eur:
        print "european"
        out.write("##european"+"\n")
    bleh = "#winner: "+max(pop, key=pop.get)+"\t"+ str((float(pop[max(pop, key=pop.get)])/float(sum))*100) + "%"
    out.write(bleh+"\n")
    #print other stats
    sorted_pop = sorted(pop.iteritems(), key=operator.itemgetter(1))
    out.write("#stats:"+"\n")
    for k in xrange(len(sorted_pop)):
        temp = sorted_pop[k]
        out.write(str(temp[0])+": "+str((float(temp[1])/float(sum))*100)+"%"+"\n")
        
        
    #print pop[max(pop, key=pop.get)]
    
if __name__ == "__main__":
    choose(sys.argv[1], sys.argv[2], sys.argv[3])
    
