addpath('../lib/miditoolbox')
%list of training samples
%create a txt file containing all training sample filenames 
%midiPath= '../audio/human_played_midi/KV310/';
midiPath= '../data/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';

melodyOnly =    1;

%choose feature analyze modules
useFeature(1) = 1; %doPosInPhrase = 1;
%choose performance param modules
usePerform(1) = 1; %%doTimeBias =    1;

%choose modeling method
useRegression = 1;

%modeling
visualize =     0;

defaultTempo = 30;
