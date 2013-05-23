import os.path

DEBUG = True
#DEBUG = False 
defaultTrainSampleList= "../training_samples/trainSampleList.txt"
unittestTrainSampleList="../training_samples/trainSampleList.txt"
defaultGenScore=        "../testing_scores/chop_nc_phrase001"

#defaultTrainFeatsFilename="../output/trainFeats.json" #may need to prepend file name 
#defaultGenFeatFilename="../output/genFeat.json"
#defaultModelFilename=  "../output/model.bin"
defaultOutputDir=      "../output/"
scoreFeatsList = [ "PosInPhrasePercent",
                   "PitchMidiNum",
                   "PitchDiffNextMidiNum",
                   "PitchDiffPrevMidiNum",
                   "Beat",
                   "BeatStrength",
                   "DurationQNote",
                   "DurationRatioNextPercent",
                   "DurationRatioPrevPercent", ]

perfFeatsList = [ "OnsetDiffQNote",
                  "DurationPercent",
                  "VelocityMidiScale",
                ]

modelFuncName = [ #"modelMultiLinearRegress",
                  "modelSVMStruct",
                  #"ha",
                ]

quantizerName= [ "quantizerLinear",
                  #"ha",
                ]
musicOutputFormat= [ "Midi",
                        #"ha",
                   ]
def printDebug(string):
   if DEBUG:
      print("[DEBUG]"),
      print(string)

def sanitizeDirPath(dirPath):
   if not (dirPath.endswith("/")):
      return dirPath + "/";
   else: 
      return dirPath;

def getTrainSampleName(trainSampleFilename):
   return os.path.splitext(os.path.basename(trainSampleFilename))[0]

def getGenSampleName(genSampleFilename):
   return os.path.basename(genSampleFilename)

def getTrainFeatFilename(args):
   trainFeatsFilename = sanitizeDirPath(args.outputDir)
   trainFeatsFilename += getTrainSampleName(args.inputList)
   trainFeatsFilename += ".trainFeats.json"
   return trainFeatsFilename

def getGenFeatFilename(args):
   trainFeatsFilename = sanitizeDirPath(args.outputDir)
   trainFeatsFilename += getTrainSampleName(args.input)
   trainFeatsFilename += ".genFeats.json"
   return trainFeatsFilename

def getModelFilename(args):
   modelFilename = sanitizeDirPath(args.outputDir)
   modelFilename += getTrainSampleName(args.inputList) + "."
   modelFilename += modelFuncName[0] + ".model"
   return modelFilename

