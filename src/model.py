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
   logging.printDebug("trainFeats: ")
   logging.printDebug(trainFeats)
   collectedFeats = {}
   for featName in getattr(config, featType+'List'):
      collectedFeats[featName] = []
      logging.printDebug(trainFeats)
      for score in trainFeats:
         #logging.printDebug(score)
         #logging.printDebug("featName: " + featName)
         #logging.printDebug("featType: " + featType)
         collectedFeats[featName].extend(score[featType][featName])
   return collectedFeats

class model:
   def train(self, args):
      #see collectFeats() for trainFeat format
      #train the model and save to modelFilename
      raise NotImplementedError("Model subclass must implement this function.")
   def gen(self, args):
      #genFeat format:
      # { 
      #    {"scoreFeats": { "feat1":[1,2,3...], "feat2":[3,4,3...]}}
      # }
      #perfFeats:
      # { 
      #    { "feat1":[1,2,3...], "feat2":[3,4,3...]}
      # }
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
      logging.printDebug(formula)
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
      logging.printDebug(scoreFeats)
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
      logging.printDebug('PerfFeatures from genModel')
      logging.printDebug(perfFeats)
      logging.printDebug(perfFeats.items())
      if len(perfFeats) == 1:
         newPerfFeats = {} 
         for key, val in perfFeats.items(): 
            newPerfFeats[config.perfFeatsList[0]] = val
         return newPerfFeats
      return perfFeats

class modelSVMStruct(model):
   #condiser rename to modelSVMHMM
   #trainBinPath = " ../svm_hmm/svm_hmm/svm_hmm_learn"
   #genBinPath= "../svm_hmm/svm_hmm/svm_hmm_classify"
   trainBinPath = " ~/svm_hmm/svm_hmm/svm_hmm_learn"
   genBinPath= "~/svm_hmm/svm_hmm/svm_hmm_classify"
   def formatLine(self, scoreFeats):
      #from {feat1:[1,2,3...], feat2:[4,5,6...]} to [[1,4], [2,5], 3,6]...]
      #i.e from one feature one row to one note one row
      lines = []
      feats = zip(*scoreFeats.values()) # each elem is a note [feat1, feat2, ...]]
      #logging.printDebug(feats)
      for note in feats:
         line = ""
         for i in range(0, len(note)):
            line += "{0}:{1} ".format(i+1, note[i]);
            #logging.printDebug(line)
         lines.append(line)
      return lines

   def formatLineDirect(self, trainFeats):
   #this handles trainFeats directly, w/out use collectFeats
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
      lines = []
      qid = 0
      for score in trainFeats:
         qid += 1
         feats = zip(*score['scoreFeats'].values()) # each elem is a note [feat1, feat2, ...]]
         for note in feats:
            line = "qid:" + str(qid) + " "
            for i in range(0, len(note)):
               line += "{0}:{1} ".format(i+1, note[i]);
            lines.append(line)
      return lines
   def getQuantizeFilename(self, args, featName):
      if hasattr(args, "modelFilename"): # for gen case
         quantFilename = args.modelFilename
      else: # for train case
         quantFilename = config.sanitizeDirPath(args.outputDir)
         quantFilename += config.getModelFilename(args)
      quantFilename += "." + featName + ".quant"
      return quantFilename

   def getTrainInputFilename(self, args, featName):
      svmFilename = config.sanitizeDirPath(args.outputDir)
      svmFilename += config.getModelFilename(args)
      svmFilename += "." + featName + ".train.input.dat"
      return svmFilename

   def getGenInputFilename(self, args):
      svmFilename = config.sanitizeDirPath(args.outputDir)
      svmFilename += config.getGenSampleName(args.input) + "."
      svmFilename += config.modelFuncName[0] + "."
      svmFilename += "gen.input.dat"
      return svmFilename

   def getGenOutputFilename(self, args, featName):
      svmFilename = config.sanitizeDirPath(args.outputDir)
      svmFilename += config.getGenSampleName(args.input) + "."
      svmFilename += config.modelFuncName[0] + "."
      svmFilename += featName + "."
      svmFilename += "gen.output.dat"
      return svmFilename

   def getSingleModelFilename(self, args, featName):
      if hasattr(args, "modelFilename"): # for gen case
         singleModelFilename = args.modelFilename
      else: # for train case
         singleModelFilename = config.sanitizeDirPath(args.outputDir)
         singleModelFilename += config.getModelFilename(args)
      singleModelFilename += "." + featName + ".model.bin"
      return singleModelFilename


   def train(self, args):
      #ex filenames:
      # trainFeat.json -> [quantizer] -> <perfFeatName>.train.dat 
      #                       |                                 |
      #                       +->  <perfFeatName>.quant         |
      # +-------------------------------------------------------+
      # +-> [svm^hmm] -> <perfFeatName>.model.bin

      trainFeats = featureManager.loadJson(config.getTrainInFeatFilename(args))
      perfFeats = collectPerfFeats(trainFeats)
      logging.printDebug(perfFeats)
      #for each perfFeature, a svmFeatFilename (quantized feat for svm^hmm)
      #and singleModelFilename (model file for svm^hmm) will be saved
      #scoreFeatLines = self.formatLine(scoreFeats) 
      scoreFeatLines = self.formatLineDirect(trainFeats) 
      for pkey, pval in perfFeats.items():
         allLines = [("# " + pkey)]
         #TODO:quantize pval
         q = quantizer.getQuantizerObj(self.getQuantizeFilename(args, pkey))
         quantizedVal = q.quantize(pval)
         lines = zip(map(str, quantizedVal), scoreFeatLines) 
         logging.printDebug(lines)
         allLines = map(lambda l:" ".join(l), lines)
         logging.printDebug(allLines)

         svmFeatFilename = self.getTrainInputFilename(args, pkey)
         with open(svmFeatFilename, 'w') as f:
            f.writelines(map(lambda x:x+"\n", allLines))

         cmd = [self.trainBinPath]
         if (config.svmhmm_c != None):
             cmd.append("-c " + str(config.svmhmm_c))
         else:
             cmd.append("-c 0.01")
         cmd.append(svmFeatFilename)
         singleModelFilename = self.getSingleModelFilename(args,pkey)
         cmd.append(singleModelFilename)

         logging.printDebug(" ".join(cmd))
         subprocess.call(" ".join(cmd), shell=True)

   def gen(self, args):
      genFeats = featureManager.loadJson(config.getGenInFeatFilename(args))
      genFeat = genFeats[0]
      scoreName = genFeat['name']
      scoreFeats = genFeat['scoreFeats']
      #wrap genFeats in [] to match data structure in train
      lines = self.formatLineDirect([genFeat]) 
      logging.printDebug(lines)
      allLines = map(lambda l: "0 " + l, lines)
      logging.printDebug(allLines)

      #TODO: collect filenames

      SVMGenInputFilename = self.getGenInputFilename(args)

      with open(SVMGenInputFilename, 'w') as f:
         f.writelines(map(lambda x:x+"\n", allLines))

      for featName in config.perfFeatsList:
         cmd = [self.genBinPath]
         cmd.append(SVMGenInputFilename)
         singleModelFilename= self.getSingleModelFilename(args, featName)
         cmd.append(singleModelFilename)
         perfFeatFilename= self.getGenOutputFilename(args, featName)
         cmd.append(perfFeatFilename)

         logging.printDebug(" ".join(cmd))
         subprocess.call(" ".join(cmd), shell=True)

         #TODO: read all perfFeatFilename, transform to dict and return 


      perfFeats = {}
      for featName in config.perfFeatsList:
         #TODO: put all filename definition in one place
         #perfFeatFilename= self.getGenOutputFilename(args, featName)
         with open(perfFeatFilename, 'r') as f:
             lines = f.readlines()
         #dequantize
         q = quantizer.getQuantizerObj(self.getQuantizeFilename(args, featName))
         realVals= q.dequantize(lines)
         #feat = map(float, lines)
         perfFeats[featName]=realVals

      logging.printDebug(perfFeats)
      return featureManager.formatFeatFile(scoreName, {}, perfFeats)
      #return perfFeats


