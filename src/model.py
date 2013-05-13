import subprocess
from rpy import *

import featureManager
import config
import quantizer 
#import simplejson
#import pickle

def getModelObj():
   if len(config.modelFuncName) != 1:
      raise Exception("[ERROR] You can only select one model in config.py")
   className = globals()[config.modelFuncName[0]]
   return className()

def collectScoreFeats(trainFeats):
   return collectFeats(trainFeats, 'scoreFeats')

def collectPerfFeats(trainFeats):
   return collectFeats(trainFeats, 'perfFeats')

def collectFeats(trainFeats, featType):
   #trainFeats structure:
   # [
   #  { 
   #    name:'score1',
   #    scoreFeats:{ feat1name:[1,2,3...], feat2name:[2,3,4...] ...},
   #    perfFeats:{ feat1name:[1,2,3...], feat2name:[2,3,4...] ...}
   #  }
   #  { 
   #     name:'score2',
   #     scoreFeats:{ feat1name:[1,2,3...], feat2name:[2,3,4...] ...},
   #     perfFeats:{ feat1name:[1,2,3...], feat2name:[2,3,4...] ...}
   #  }
   # ]
   #
   # collectedFeats structure (scoreFeats for example):
   #  {
   #     feat1name: [1,2,3....2 3 4,...3 9 4,...],
   #     feat2name: [1,2,3....2 3 4,...3 9 4,...],
   #  }
   #
   config.printDebug("trainFeats: ")
   config.printDebug(trainFeats)
   collectedFeats = {}
   for featName in getattr(config, featType+'List'):
      collectedFeats[featName] = []
      config.printDebug(trainFeats)
      for score in trainFeats:
         #config.printDebug(score)
         #config.printDebug("featName: " + featName)
         #config.printDebug("featType: " + featType)
         collectedFeats[featName].extend(score[featType][featName])
   return collectedFeats

class model:
   def train(self, trainFeatFilename, modelFilename):
      #see collectFeats() for trainFeat format
      #train the model and save to modelFilename
      raise NotImplementedError("Model subclass must implement this function.")
   def gen(self, genFeatFilename, modelFilename):
      #genFeat format:
      # { 
      #    "scoreFeats": { "feat1":[1,2,3...], "feat2":[3,4,3...]}
      # }
      #perfFeats:
      # { "feat1":[1,2,3...], "feat2":[3,4,3...]}
      #
      #load modelFilename and return perfFeats
      raise NotImplementedError("Model subclass must implement this function.")



class modelMultiLinearRegress(model):
   def train(self, trainFeatFilename, modelFilename):
      trainFeats = featureManager.loadJson(trainFeatFilename)
      scoreFeats = collectScoreFeats(trainFeats)
      perfFeats = collectPerfFeats(trainFeats)
      #data = r('data.frame(scoreFeats, perfFeats)')
      formula = 'cbind(' + ','.join(config.perfFeatsList) +')'
      formula += '~'
      formula += '*'.join(config.scoreFeatsList)
      config.printDebug(formula)
      r.assign('fstr', formula)
      r.assign('scoreFeats',scoreFeats)
      r.assign('perfFeats',perfFeats)
      r('f <- formula(fstr)')
      r('scoreFeats <- data.frame(scoreFeats)')
      r('perfFeats <- data.frame(perfFeats)')
      if config.DEBUG: 
         r('str(perfFeats)')
         r('str(scoreFeats)')
         r('str(f)')
      r.assign('modelFilename',modelFilename)

      r.source('modelMultiLinearRegress.R')
      r('trainMultiLinearRegress(f, perfFeats, scoreFeats, modelFilename)')

   def gen(self, genFeatFilename, modelFilename):
      genFeats = featureManager.loadJson(genFeatFilename)
      scoreFeats = genFeats['scoreFeats']
      config.printDebug(scoreFeats)
      r.assign('scoreFeats',scoreFeats)
      r.assign('modelFilename',modelFilename)
      r('scoreFeats <- data.frame(scoreFeats)')
      if config.DEBUG: 
         r('str(scoreFeats)')
         r('save(scoreFeats, file="../output/debug_genFeat.rda")')
      r.source('modelMultiLinearRegress.R')
      perfFeats = r('perfFeats<-genMultiLinearRegress(scoreFeats, modelFilename)')
      if config.DEBUG: r('str(perfFeats)')
      #workaround: if only one perfFeat is used. predict will return a bad format data.frame without proper perfFeatName
      config.printDebug('PerfFeatures from genModel')
      config.printDebug(perfFeats)
      config.printDebug(perfFeats.items())
      if len(perfFeats) == 1:
         newPerfFeats = {} 
         for key, val in perfFeats.items(): 
            newPerfFeats[config.perfFeatsList[0]] = val
         return newPerfFeats
      return perfFeats

class modelSVMStruct(model):
   #condiser rename to modelSVMHMM
   trainBinPath = " ../svm_hmm/svm_hmm/svm_hmm_learn"
   genBinPath= "../svm_hmm/svm_hmm/svm_hmm_classify"
   def formatLine(self, scoreFeats):
      #from {feat1:[1,2,3...], feat2:[4,5,6...]} to [[1,4], [2,5], 3,6]...]
      #i.e from one feature one row to one note one row
      lines = []
      feats = zip(*scoreFeats.values()) # each elem is a note [feat1, feat2, ...]]
      #config.printDebug(feats)
      for note in feats:
         line = ""
         for i in range(0, len(note)):
            line += "{0}:{1} ".format(i+1, note[i]);
            #config.printDebug(line)
         lines.append(line)
      return lines

   def addQid(self, line):
      #lineList = [line]
      #lineList.insert(1, "qid:1")
      return "qid:1 " + line
      #return " ".join(map(lambda x:str(x) ,lineList))


   def train(self, trainFeatFilename, modelFilename):
      #ex filenames:
      # trainFeat.json -> [quantizer] -> <perfFeatName>.train.dat 
      #                       |                                 |
      #                       +->  <perfFeatName>.quant         |
      # +-------------------------------------------------------+
      # +-> [svm^hmm] -> <perfFeatName>.model.bin

      trainFeats = featureManager.loadJson(trainFeatFilename)
      scoreFeats = collectScoreFeats(trainFeats)
      perfFeats = collectPerfFeats(trainFeats)
      config.printDebug(perfFeats)
      #for each perfFeature, a svmFeatFilename (quantized feat for svm^hmm)
      #and singleModelFilename (model file for svm^hmm) will be saved
      scoreFeatLines = self.formatLine(scoreFeats) 
      for pkey, pval in perfFeats.items():
         allLines = [("# " + pkey)]
         #TODO:quantize pval
         q = quantizer.getQuantizerObj(config.defaultOutputDir+ modelFilename + pkey+'.quant')
         quantizedVal = q.quantize(pval)
         linesWQid = map(self.addQid, scoreFeatLines)
         lines = zip(map(str, quantizedVal), linesWQid) 
         config.printDebug(lines)
         allLines = map(lambda l:" ".join(l), lines)
         config.printDebug(allLines)

         svmFeatFilename = config.defaultOutputDir + modelFilename + pkey + ".train.dat"
         with open(svmFeatFilename, 'w') as f:
            f.writelines(map(lambda x:x+"\n", allLines))

         cmd = [self.trainBinPath]
         cmd.append("-c 0.01")
         cmd.append(svmFeatFilename)
         singleModelFilename= config.defaultOutputDir + modelFilename +  pkey + ".model.bin" 
         cmd.append(singleModelFilename)

         config.printDebug(" ".join(cmd))
         subprocess.call(" ".join(cmd), shell=True)

   def gen(self, genFeatFilename, modelFilename):
      genFeats = featureManager.loadJson(genFeatFilename)
      scoreName = genFeats['name']
      scoreFeats = genFeats['scoreFeats']
      lines = self.formatLine(scoreFeats)
      config.printDebug(lines)
      allLines = map(self.addQid, lines)
      allLines = map(lambda l: "0 " + l, lines)
      config.printDebug(allLines)

      #TODO: collect filenames
      scoreFeatFilename = config.defaultOutputDir + scoreName
      scoreFeatFilename += ".scoreFeats.gen.dat"

      with open(scoreFeatFilename, 'w') as f:
         f.writelines(map(lambda x:x+"\n", allLines))

      for featName in config.perfFeatsList:
         cmd = [self.genBinPath]
         cmd.append(scoreFeatFilename)
         singleModelFilename= config.defaultOutputDir + featName + ".model.bin" 
         cmd.append(singleModelFilename)
         perfFeatFilename= config.defaultOutputDir + scoreName + '.' +  featName 
         perfFeatFilename+= ".gen.dat"
         cmd.append(perfFeatFilename)

         config.printDebug(" ".join(cmd))
         subprocess.call(" ".join(cmd), shell=True)

         #TODO: read all perfFeatFilename, transform to dict and return 


      perfFeats = {}
      for featName in config.perfFeatsList:
         #TODO: put all filename definition in one place
         perfFeatFilename= config.defaultOutputDir + scoreName + '.' +  featName 
         perfFeatFilename= config.defaultOutputDir + scoreName + '.' +  featName 
         perfFeatFilename+= ".gen.dat"
         with open(perfFeatFilename, 'r') as f:
             lines = f.readlines()
         #dequantize
         q = quantizer.getQuantizerObj(config.defaultOutputDir+featName+'.quant')
         realVals= q.dequantize(lines)
         #feat = map(float, lines)
         perfFeats[featName]=realVals

      config.printDebug(perfFeats)
      return perfFeats







