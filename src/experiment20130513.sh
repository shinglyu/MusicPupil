#!/bin/sh

for i in 1 2 3 4 5
do
    ./musicPupilTrain.py ../training_samples/trainList0$i.txt ../output/model0$i.txt
done
