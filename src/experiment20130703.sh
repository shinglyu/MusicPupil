#!/bin/sh

date=20130703
#Objective: Test run for testing separated music generator

mkdir ../output$date

for i in 1 #2 3 4 5
do
    ./musicPupilTrain.py ../training_samples/trainList0$i.txt ../output$date
    ./musicPupilGenBatch.py ../testing_scores/genList0$i.txt ../output$date/trainList0$i.modelSVMStruct.model ../output$date
done

