addpath('../lib/miditoolbox')
debug_mode =    1;
%list of training samples
%create a txt file containing all training sample filenames 
%midiPath= '../audio/human_played_midi/KV310/';
midiPath= '../data/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';

melodyOnly =    1;

%choose feature analyze modules
useFeature(1) = 0; %doPosInPhrase = 1;
useFeature(2) = 0; %doPitch= 1;
useFeature(3) = 0; %doRelativePitch= 1;
useFeature(4) = 1; %ScoreDuration= 1;
%choose performance param modules
usePerform(1) = 0; %%doTimeBias =    1;
usePerform(2) = 0; %%doLoudness=    1;
usePerform(3) = 1; %%doRealDuration=    1;


%choose modeling method
useRegression = 1;

%modeling
visualize =     1;

defaultTempo = 30;
