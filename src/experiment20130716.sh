#!/bin/sh

date="20130716"
#Objective: Test single score feature's effect on model

for i in 11 12 13 14 15 16 17 18 19 
#for i in 2 3 4 5 6 7 8 9 
do
    dir=../output$date\_$i/

    mkdir $dir

    cp config_$i.py config.py
    cp config_$i.py $dir

    for k in 1 2 3 4 5
    do
        ./musicPupilTrain.py ../training_samples/trainList0$k.txt $dir
        ./musicPupilGenBatch.py ../testing_scores/genList0$k.txt $dir/trainList0$k.modelSVMStruct.model $dir
    done

    python ana_comparePerfFeats.py $dir
    Rscript ana_comparePerfFeats.R $dir config_$i

    evince $dir/comparePerfFeats.config_$i.svg &

    cp $dir/comparePerfFeats.config_$i.svg ../summary
    cp config_$i.py ../summary
done

cp config.py.bk config.py


