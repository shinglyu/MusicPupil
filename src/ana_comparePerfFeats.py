'''
This file is to prepare the log file for ana_comparePerfFeats.R to analyze

desired output:
category feat1 feat2 feat3
real     1.2   2.5   3.5
real     2.7   5.8   4.0
gen
gen
...

'''

import featureManager
import model 

import os 
import fnmatch 
import simplejson


#realPerfDir = "../training_samples/"
DEBUG = False; #
perfDir= "../output20130713/"
realPerfExt= "*.train.allFeats.json"
genPerfExt= "*.gen.perfFeats.json"
outputFilename = "comparePerfFeats.txt"

filenames = os.listdir(perfDir)
realPerfFilnames = fnmatch.filter(filenames, realPerfExt)
genPerfFilnames  = fnmatch.filter(filenames, genPerfExt)

def parseColNames(feats):
   collectedFeats = model.collectPerfFeats(feats);

   return ["group\t" + "\t".join(collectedFeats.keys())] # each line is a vector


def parseLines(feats, group ):
   lines = []
   collectedFeats = model.collectPerfFeats(feats);

   #names = "group\t" + "\t".join(collectedFeats.keys())
   #lines.append(names)

   valueLines = zip(*collectedFeats.values()) #[(feat1, feat2), (feat1, feat2)]
   for line in valueLines:
      lineStr = map(str, list(line))
      #lines.append('\t'.join(lineStr) + "\n")
      lines.append(group + '\t' + '\t'.join(lineStr) )


   return lines

#main
lines = []

#prepare col names
feat = featureManager.loadJson(perfDir + realPerfFilnames[0]);
lines += parseColNames(feat)

for realPerfFilname in realPerfFilnames:
   if (DEBUG):
      lines += ["# " + realPerfFilname]
   realFeats = featureManager.loadJson(perfDir + realPerfFilname);
   lines += parseLines(realFeats, "real")

   
for genPerfFilname in genPerfFilnames:
   if (DEBUG):
      lines += ["# " + genPerfFilname]
   genFeats = featureManager.loadJson(perfDir + genPerfFilname);
   lines += parseLines(genFeats, "gen")

for line in lines:
   print(line)

with open(perfDir + outputFilename, 'w') as f:
    f.writelines('\n'.join(lines))

