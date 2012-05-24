addpath('../lib/miditoolbox')
addpath('../lib/midirw_java')
addpath('./features')
addpath('./performs')
addpath('./similarity')
debug_mode =    0;
%list of training samples
%create a txt file containing all training sample filenames 
%midiPath= '../audio/human_played_midi/KV310/';
midiPath= '../data/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';
sampSize= 0.5; %0~1 (percent)

melodyOnly= 1;
playMelodyOnly = 1;

%choose feature analyze modules
useFeature(1) = 1; %doPosInPhrase = 1;
useFeature(2) = 0; %doPitch= 1;
useFeature(3) = 1; %doRelativePitch= 1;
useFeature(4) = 1; %ScoreDuration= 1;
useFeature(5) = 1; %PitchDiffPerv
useFeature(6) = 1; %PitchDiffPerv
%choose performance param modules
usePerform(1) = 0; %%doTimeBias =    1;
usePerform(2) = 1; %%doLoudness=    1;
usePerform(3) = 1; %%doRealDuration=    1;
usePerform(4) = 1; %%relaTimeBias=    1;


%choose modeling method
useRegression = 1;

%modeling
visualize =     1;

defaultTempo = 30;
