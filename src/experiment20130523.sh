#!/bin/sh

for i in 1 2 3 4 5
do
    ./musicPupilTrain.py ../training_samples/trainList0$i.txt ../output/model0$i
done

#TODO: write a musicPupilBatchGen.py wraps around musicPupilGen.py, which can read a list.txt and play all pieces, so we can have training/testing list pair
for i in 1 2 3 4 5
do
    ./musicPupilGen.py ../testing_scores/fostr35.4 ../output/model0$i ../experiment20130513/model0$i\.
done
