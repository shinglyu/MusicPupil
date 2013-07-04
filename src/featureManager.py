import config
import scoreFeature
import perfFeature 
#import json
import simplejson

def extractTrainFeat(sample):
   name = sample['name']
   scoreFeats = extractFeats(sample, 'score')
   perfFeats = extractFeats(sample, 'perf')
   return {'name':name, 'scoreFeats':scoreFeats, 'perfFeats':perfFeats} 

def extractGenFeat(sample):
   name = sample['name']
   scoreFeats = extractFeats(sample, 'score')
   return {'name':name, 'scoreFeats':scoreFeats} 

def extractFeats(sample, featType):
   feats={}
   for featName in getattr(config, featType + 'FeatsList'):
      module = __import__(featType+'Feature')
      featFunc = getattr(module, 'extract' + featName)
      feats[featName]= (featFunc(sample))
   return feats 

def applyFeats(inScore, perfFeats):
   outScore = inScore
   for featName , featValue in perfFeats.items():
      applyFunc = getattr(perfFeature, 'apply'+featName)
      outScore = applyFunc(outScore, perfFeats)
      config.printDebug(applyFunc)
   #config.printDebug(outScore)
   #if config.DEBUG: outScore['score'].show('text')
   return outScore

def saveJson(featList, filename):
   with open(filename, 'w') as f:
      simplejson.dump(featList, f, indent=3)

def loadJson(filename):
   with open(filename, 'r') as f:
      return simplejson.load(f, encoding='utf-8')

