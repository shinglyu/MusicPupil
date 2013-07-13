useSvg = FALSE 
args <- commandArgs()
print(args)

if (length(args) >= 6){ dir = args[6]} else{ dir = "../output20130713/"} 
filename = "comparePerfFeats"

#perf <- read.table("../output20130703/allPerfFeats.txt", header=TRUE, sep="\t", row.names=NULL)
perf <- read.table(paste(dir, filename, ".txt", sep=""), header=TRUE, sep="\t", row.names=NULL)

perf$VelocityMidiScale <- as.numeric(perf$VelocityMidiScale)	
perf$OnsetDiffQNote	<- as.numeric(perf$OnsetDiffQNote)
perf$DurationPercent <- as.numeric(perf$DurationPercent)


attach(perf)
#after read, the three numerical cols are treated as factor(categorical). Use as.numeric(as.character(...)) to convert
if(useSvg){
    svg(paste(dir, filename , ".svg", sep=""))
}else{
    pdf(paste(dir, filename , ".pdf", sep=""))
}

par(mfrow=c(1,3), oma=c(0,0,2,0))
lapply(colnames(perf[2:4]),FUN=function(x){boxplot(perf[,x]~group, main=as.character(x))})
#library(vioplot)
#lapply(colnames(perf[2:4]),FUN=function(x){
#       x1 <- perf$x[perf$group=='real']
#       x2 <- perf$x[perf$group=='gen']
#       vioplot(x1,x2, names=c('real','gen'))})
#title("All Score Features", outer=TRUE)
title("All Score Features", outer=TRUE)
#lapply(colnames(perf[2:4]),FUN=function(x){boxplot(x~group,data=perf, main=as.character(x))})
#boxplot(VelocityMidiScale~group,data=perf, main="VelocityMidiScale")
#boxplot(VelocityMidiScale~group, main="VelocityMidiScale")
#boxplot(VelocityMidiScale~group, main="VelocityMidiScale")
#ggplot(perf, aes(x=group, y=VelocityMidiScale, colour=group)) + 
#geom_errorbar(aes(ymin=VelocityMidiScale-10, ymax=VelocityMidiScale+10), width=.1) +
#geom_line() +
#geom_point()
