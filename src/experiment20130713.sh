#!/bin/sh

date="20130713"
#Objective: Test run for testing separated music generator


for i in 1 2 3 4 5 6 7 8 9 
do
    mkdir ../output$date_$i
    cp config_$i.py config.py
    ./musicPupilTrain.py ../training_samples/trainList0$i.txt ../output$date_$i
    ./musicPupilGenBatch.py ../testing_scores/genList0$i.txt ../output$date_$i/trainList0$i.modelSVMStruct.model ../output$date_$i
done

python ana_comparePerfFeats.py
Rscript ana_comparePerfFeats.R
evince ../output$date_$i/comparePerfFeats.pdf

