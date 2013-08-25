'''
Created on Jun 2, 2013

@author: ALEX
This is meant to calculate probabilities of alternate alleles for each of 6 population groups
Uses haplotype data from 1000 Genomes Project
Output file used with APchoice.py to identify ethnicity
'''
#happarse.py will read in haplotype file for a chr, pull the columns corresponding to each pop
#also pull columns of rs IDs
#take val = (0/1)*(freq%) for each rs, for each individual, store in list
#For each pop group, take average of scores of vectors in set, generate consensus haplotype data
#write out file containing list of rsID and freq values for a given pop

import sys

def happarse(hfile):
    cnslist = []
    with open(hfile,'r') as f:
        content = f.readlines()
    f.close()
    print "# rsID asw ceu chb jpt lwk tsi yri"
    for i in xrange(len(content)):
        if not content[i].startswith("##"):
            if not content[i].startswith("#"):
                tmp = content[i].split()
                if len(tmp[2]) > 1:
                    snp = tmp[2]
                    #for each ceu individual
                    ceup1 = makescore(420, 507, tmp)
                    yri1 = makescore(508,526, tmp) 
                    yri2 = makescore(624,643,tmp)
                    yri3 = makescore(742,789,tmp)
                    yrip1 = float(yri1+yri2+yri3)/3
                    chbp1 = makescore(527,623,tmp)
                    jpt1 = makescore(645,703,tmp)
                    jpt2 = makescore(712,741,tmp)
                    jptp1 = float(jpt1+jpt2)/2
                    lwk1 = makescore(704, 711, tmp)
                    lwk2 = makescore(790,878,tmp)
                    lwkp1 = float(lwk1+lwk2)/2
                    asw1 = makescore(899,906,tmp)
                    asw2 = makescore(954,1005,tmp)
                    aswp1 = float(asw1+asw2)/2
                    tsip1 = makescore(1006,1103, tmp)
                    record = snp+"\t"+str(aswp1)+"\t"+str(ceup1)+"\t"+str(chbp1)+"\t"+str(jptp1)+"\t"+str(lwkp1)+"\t"+str(tsip1)+"\t"+str(yrip1)
                    print record
                    cnslist.append(record)
    #oname = str(hfile.split(".")[1])+".popstats.txt"
    #out = open(oname,'w')
    #out.write("# rsID asw ceu chb jpt lwk tsi yri"+"\n")
    #for j in xrange(len(cnslist)):
        #out.write(cnslist[j]+"\n")
    
    
#take column indexes of individuals from specific population, and list as input
#prob1 = probability of alt allele given you are certain population          
def makescore(ind1, ind2, t):
    probs = []
    count = 0
    for i in xrange(ind1, ind2):
        gtap = t[i].split(":")
        #Get alleles for individual
        gt = gtap[0]
        all1 = int(gt.split("|")[0])
        all2 = int(gt.split("|")[1])
        if all1 == 1:
            count = count+1
        if all2 == 1:
            count = count+1
        #ap = float(gtap[1][2:7])
        #score = gt*ap
        #probs.append(score)
    prob1 = float(count)/float(2*(ind2-ind1))
    return prob1
if __name__ == "__main__":
    happarse(sys.argv[1])
    
