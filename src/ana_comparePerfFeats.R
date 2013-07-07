perf <- read.table("../output20130703/allPerfFeats.txt", header=TRUE, sep="\t", row.names=NULL)
#after read, the three numerical cols are treated as factor(categorical). Use as.numeric(as.character(...)) to convert
boxplot(perf, main="VelocityMidiScale")
#ggplot(perf, aes(x=group, y=VelocityMidiScale, colour=group)) + 
#geom_errorbar(aes(ymin=VelocityMidiScale-10, ymax=VelocityMidiScale+10), width=.1) +
#geom_line() +
#geom_point()
