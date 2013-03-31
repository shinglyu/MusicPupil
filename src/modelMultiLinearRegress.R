trainMultiLinearRegress<- function(fmu, perfFeats, scoreFeats, modelFilename){
   model <- lm(fmu, data = data.frame(perfFeats, scoreFeats))
   save(model, file=modelFilename)
   #summary(model)
}

genMultiLinearRegress<- function(scoreFeats, modelFilename){
   load(modelFilename) #loads "model"
   data.frame(predict(model, scoreFeats))
}
