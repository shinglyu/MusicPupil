import os.path

#DEBUG = True
DEBUG = False 
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
#SVM^HMM related parameters
#svmhmm_c = None
svmhmm_c = 10

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

def getTrainInFeatFilename(args):
   trainFeatsFilename = sanitizeDirPath(args.outputDir)
   trainFeatsFilename += getTrainSampleName(args.inputList)
   trainFeatsFilename += ".train.allFeats.json"
   return trainFeatsFilename

def getGenSampleName(genSampleFilename):
   return os.path.basename(genSampleFilename)

def getGenInFeatFilename(args):
   trainFeatsFilename = sanitizeDirPath(args.outputDir)
   trainFeatsFilename += getGenSampleName(args.input)
   trainFeatsFilename += ".gen.scoreFeats.json"
   return trainFeatsFilename

def getGenOutFeatFilename(args):
   trainFeatsFilename = sanitizeDirPath(args.outputDir)
   trainFeatsFilename += getGenSampleName(args.input)
   trainFeatsFilename += ".gen.perfFeats.json"
   return trainFeatsFilename

def getModelFilename(args):
   modelFilename = sanitizeDirPath(args.outputDir)
   modelFilename += getTrainSampleName(args.inputList) + "."
   modelFilename += modelFuncName[0] + ".model"
   return modelFilename

