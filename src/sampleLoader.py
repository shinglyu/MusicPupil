import config
import os.path
from music21 import converter

def parseFileList(inputList):
   dirName = os.path.dirname(inputList)
   #TODO: change to json format
   with open(inputList) as f:
      filenames = f.readlines()
      return map(lambda x:dirName+"/"+x.strip(), filenames)


def loadTrainSample(sampleName):
   scoreName = sampleName+ ".score.mid";
   metaName = sampleName+ ".meta";
   perfName = sampleName+ ".perf.mid";
   score = converter.parse(scoreName);
   with open(metaName) as f:
      meta = f.readlines()
   perf = converter.parse(perfName);
   name = os.path.basename(sampleName)
   return {'name': name, 'score':score, 'meta':meta, 'perf':perf}

def loadGenScore(sampleName):
   scoreName = sampleName + ".score.mid";
   metaName = sampleName+ ".meta";
   score = converter.parse(scoreName);
   with open(metaName) as f:
      meta = f.readlines()
   name = os.path.basename(sampleName)
   return {'name': name, 'score':score, 'meta':meta}


