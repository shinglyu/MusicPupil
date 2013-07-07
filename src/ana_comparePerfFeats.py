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
perfDir= "../output20130703/"
realPerfExt= "*.train.allFeats.json"
genPerfExt= "*.gen.perfFeats.json"

filenames = os.listdir(perfDir)
realPerfFilnames = fnmatch.filter(filenames, realPerfExt)
genPerfFilnames  = fnmatch.filter(filenames, genPerfExt)

def parseColNames(feats):
   collectedFeats = model.collectPerfFeats(feats);

   return "group\t" + "\t".join(collectedFeats.keys())


def parseLines(feats, group ):
   lines = []
   collectedFeats = model.collectPerfFeats(feats);

   names = "group\t" + "\t".join(collectedFeats.keys())
   lines.append(names)

   valueLines = zip(*collectedFeats.values()) #[(feat1, feat2), (feat1, feat2)]
   for line in valueLines:
      lineStr = map(str, list(line))
      #lines.append('\t'.join(lineStr) + "\n")
      lines.append(group + '\t' + '\t'.join(lineStr) )


   return lines

lines = []
for realPerfFilname in realPerfFilnames:
   realFeats = featureManager.loadJson(perfDir + realPerfFilname);
   lines += parseLines(realFeats, "real")

   
for genPerfFilname in genPerfFilnames:
   genFeats = featureManager.loadJson(perfDir + genPerfFilname);
   lines += parseLines(realFeats, "gen")

for line in lines:
   print(line)



