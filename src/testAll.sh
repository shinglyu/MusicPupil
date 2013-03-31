#!/bin/sh
./musicPupilTrain.py
./musicPupilGen.py
timidity ../output/test2.expressive.mid
