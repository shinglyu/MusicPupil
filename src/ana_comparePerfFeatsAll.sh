#!/bin/sh

#date="20130713"
##Objective: Test run for testing separated music generator
#
#for i in 1 2 3 4 5 6 7 8 9 
##for i in 2 3 4 5 6 7 8 9 
#do
#    dir=../output$date\_$i/
#
#    #python ana_comparePerfFeats.py $dir
#    Rscript ana_comparePerfFeats.R $dir config_$i
#
#    #evince $dir/comparePerfFeats.config_$i.pdf &
#
#    cp $dir/comparePerfFeats.config_$i.eps ../summary
#    #cp config_$i.py ../summary
#done

#===========================

date="20130720"
#Objective: Test different -c setting in svm_hmm

for i in 21 22 23 24 25 26 27 
#for i in 23 24 25 26 27 
#for i in 2 3 4 5 6 7 8 9 
do
    dir=../output$date\_$i/

    #python ana_comparePerfFeats.py $dir
    #Rscript ana_comparePerfFeats.R $dir config_$i

    cp $dir/comparePerfFeats.config_$i.eps ../summary

done

#===========================

date="20130720"
from=31
to=36
#Objective: Test -c from 10 50 100 500 1000, and try without onsetDiff

#for i in 21 22 23 24 25 26 27 
for i in $(seq $from $to)
#for i in 2 3 4 5 6 7 8 9 
do
    #python ana_comparePerfFeats.py $dir
    #Rscript ana_comparePerfFeats.R $dir config_$i

    cp $dir/comparePerfFeats.config_$i.eps ../summary

done


date="20130716"
#Objective: Test single score feature's effect on model

for i in 11 12 13 14 15 16 17 18 19 
#for i in 2 3 4 5 6 7 8 9 
do
    dir=../output$date\_$i/

    #python ana_comparePerfFeats.py $dir
    Rscript ana_comparePerfFeats.R $dir config_$i

    cp $dir/comparePerfFeats.config_$i.eps ../summary
done



notify-send "EPS generation finished."
