'''
Created on Jun 11, 2013

@author: ALEX

This takes in dbsnp build 137 file and a vcf 
For each entry in the vcf, finds the corresponding rs ID in dbsnp137 
Output is another vcf with rs IDs filled in
'''
import sys
import time

def mapper(db, vcf, outname):
    stime = time.time()
    snplist = []
    writeout = []
    with open(vcf,'r') as f1:
        content = f1.readlines()
        for i in xrange(len(content)):
            if content[i].startswith('#'):
                writeout.append(content[i])
            else:
                tmp = content[i].strip().split("\t")
                #record contains chr/pos: ref \t alt \t index in original file
                if not tmp[7].startswith("INDEL"):
                    record = (tmp[0]+"/"+tmp[1],(tmp[3],tmp[4],str(i)))
                    snplist.append(record)
    f1.close()
    print str(time.time()-stime)+" sec to read in vcf"
    t2 = time.time()
    print "starting into snp137.txt"
    with open(db,'r') as f2:
        for line in f2:
            tmp2 = line.strip().split()
            #chr/pos for start and stop positions
            chrpos1=tmp2[1]+"/"+tmp2[2]
            chrpos2=tmp2[1]+"/"+tmp2[3]
            dbrsID = tmp2[4]
            dbref = tmp2[7]
            for i in xrange(len(snplist)):
                key = "chr"+str(snplist[i][0])
                if key==str(chrpos1):
                    print "found"
                    r = snplist[i][1]
                    ref = r[0]
                    alt = r[1]
                    ind = int(r[2])
                    l = list(content[ind])
                    l[2] = str(dbrsID)
                    new = '\t'.join(l)
                    writeout.append(new)
                elif key == str(chrpos2):
                    print "found"
                    r = snplist[i][1]
                    ref = r[0]
                    alt = r[1]
                    ind = int(r[2])
                    l = list(content[ind])
                    l[2] = str(dbrsID)
                    new = '\t'.join(l)
                    writeout.append(new)
    f2.close()
    print str(time.time()-t2)+" sec to search through snp137.txt"
    
    out = open(outname, 'w')
    for i in xrange(len(writeout)):
        out.write(writeout[i])
    out.write(str(time.time()-stime)+" sec")
    out.close()
    print str(time.time()-stime)+" sec total"
            
if __name__ == "__main__":
    mapper(sys.argv[1],sys.argv[2],sys.argv[3])
