addpath('../lib/miditoolbox')
%list of training samples
%create a txt file containing all training sample filenames 
midiPath= '../audio/human_played_midi/KV310/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';


%choose feature analyze modules
useFeature(1) = 1; %doPosInPhrase = 1;
%choose performance param modules
usePerform(1) = 1; %%doTimeBias =    1;

%choose modeling method
useRegression = 0;

%modeling
visualize =     0;
