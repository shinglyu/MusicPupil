#!/bin/sh

date="20130812"
from=51
to=59
#Objective: Test svm_hmm parameter

#for i in 21 22 23 24 25 26 27 
for i in $(seq $from $to)
do
    #notify-send "Expriment No.$i started. "
    dir=../output$date\_$i/

    mkdir $dir

    cp config_$i.py config.py
    cp config_$i.py $dir
#done

#for i in $(seq $from $to)
#do
    for k in 1 2 3 4 5
    #for k in 0 
    do
        ./musicPupilTrain.py ../training_samples/trainList0$k.txt $dir |tee $dir/$date\_$i\_train.log 

        ./musicPupilGenBatch.py ../testing_scores/genList0$k.txt $dir/trainList0$k.modelSVMStruct.model $dir |tee $dir/$date\_$i\_gen.log 
    done
#done

#for i in $(seq $from $to)
#do
    python ana_comparePerfFeats.py $dir
    Rscript ana_comparePerfFeats.R $dir config_$i

    #evince $dir/comparePerfFeats.config_$i.svg &
    #notify-send "Expriment No.$i finished."

    cp $dir/comparePerfFeats.config_$i.eps ../summary
    cp config_$i.py ../summary
done

cp config.py.bk config.py


