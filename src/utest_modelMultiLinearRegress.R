source('modelMultiLinearRegress.R')
load('../output/debug_genFeat.rda') #scoreFeats
#load('../output/model.bin') #model
perfFeats <-genMultiLinearRegress(model, '../output/model.bin')
