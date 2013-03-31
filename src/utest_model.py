import model
import config 
import featureManager 

trainFeats = featureManager.loadJson(config.defaultTrainFeatsFilename)
print(model.collectScoreFeats(trainFeats))
print(model.collectPerfFeats(trainFeats))

model = model.trainMultiLinearRegress(trainFeats, config.defaultModelFilename)
print(model)

def dummyFunc():
   print("this is a function for type(dummyFunc) comparison")

#for mode in ['train', 'gen']:
#   print(model.getModelFunc(mode))
#   assert type(model.getModelFunc(mode)) == type(dummyFunc), 'getModelFunc() returned a non-function object'
#
