addpath('../lib/miditoolbox')
%list of training samples
%create a txt file containing all training sample filenames 
trainSamplePath = '../audio/human_played_midi/KV310/';
trainSampleName= 'sampleList.txt';


%choose analyze components
doPosInPhrase = 1;
doTimeBias =    1;
