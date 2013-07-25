#!/bin/sh

date="20130720"
from=31
to=36
#Objective: Test -c from 10 50 100 500 1000, and try without onsetDiff

#for i in 21 22 23 24 25 26 27 
for i in $(seq $from $to)
#for i in 2 3 4 5 6 7 8 9 
do
    notify-send "Expriment No.$i started. "
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

    #evince $dir/comparePerfFeats.config_$i.svg &
    notify-send "Expriment No.$i finished."

    cp $dir/comparePerfFeats.config_$i.svg ../summary
    cp config_$i.py ../summary
done

cp config.py.bk config.py


