addpath('../lib/miditoolbox')
addpath('../lib/midirw_java')
addpath('./features')
addpath('./performs')
addpath('./similarity')
debug_mode =    1;
%list of training samples
%create a txt file containing all training sample filenames 
%midiPath= '../audio/human_played_midi/KV310/';
midiPath= '../data/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';
noCache =        1;
sampSize=      0.3; %0~1 (percent)

melodyOnly=      1;
playMelodyOnly = 1;

%choose feature analyze modules
useFeature(1) = 0; %doPosInPhrase = 1;
useFeature(2) = 0; %doPitch= 1;
useFeature(3) = 0; %doRelativePitch= 1;
useFeature(4) = 0; %ScoreDuration= 1;
useFeature(5) = 0; %PitchDiffPerv
useFeature(6) = 0; %PitchDiffNext
useFeature(7) = 0; %RelaDurationPrev
useFeature(8) = 1; %RelaDurationNext
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
