#!/bin/sh

#cross validation: exclude one foster song and test on it (all phrases)

for i in 1 2 3 4 5
do
    ./musicPupilTrain.py ../training_samples/trainList0$i.txt ../output20130605
    ./musicPupilGenBatch.py ../testing_scores/genList0$i.txt ../output20130605/trainList0$i.modelSVMStruct.model ../output20130605
done

