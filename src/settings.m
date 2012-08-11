addpath('../lib/miditoolbox')
addpath('../lib/midirw_java')
addpath('./features')
addpath('./performs')
addpath('./models')
addpath('./rules')
addpath('./similarity')

debug_mode =    0;
%list of training samples
%create a txt file containing all training sample filenames 
%midiPath= '../audio/human_played_midi/KV310/';
midiPath= '../data/';
outPath = '../out/';
%trainSampleName= 'sampleList.txt';
noCache =        1;
sampSize=      0.3; %0~1 (percent)
%sampSize=        1; %0~1 (percent)

melodyOnly=      1;
playMelodyOnly = 1;

%choose feature analyze modules
useFeature(1) = 1; %doPosInPhrase = 1;
useFeature(2) = 0; %doPitch= 1;
useFeature(3) = 1; %doRelativePitch= 1;
useFeature(4) = 1; %ScoreDuration= 1;
useFeature(5) = 1; %PitchDiffPerv
useFeature(6) = 1; %PitchDiffNext
useFeature(7) = 1; %RelaDurationPrev
useFeature(8) = 1; %RelaDurationNext
useFeature(9) = 0; %MetricalPos
useFeature(10) = 1; %Metric 1
useFeature(11) = 1; %Metric 1
useFeature(12) = 1; %Metric 1
useFeature(13) = 1; %Metric 1
useFeature(14) = 1; %Metric 1
useFeature(15) = 1; %Metric 1
%choose performance param modules
usePerform(1) = 0; %%doTimeBias =    1; 
usePerform(2) = 1; %%doLoudness=    1;
usePerform(3) = 1; %%doRealDuration=    1;
usePerform(4) = 1; %%relaTimeBias=    1;

useRule(1) = 0; %%jazz01
useRule(2) = 0; %%jazz02
useRule(3) = 0; %%jazz03
useRule(4) = 0; %%jazz04
useRule(5) = 1; %%jazz04

%choose modeling method
useModel(1)   = 0; %polfit Regression
useModel(2)   = 1; %mvregress
useModel(3)   = 0; %mvregress

%modeling
visualize =     1;

defaultTempo = 30;

%playing
MIN_LOUD = 80; %minmum loudness level, default = 0
MAX_LOUD = 127; %maximum loudness level, default = 127

%Note matrix columns const
ONSET_BEATS    = 1;
DURATION_BEATS = 2;
CHANNELS       = 3;
PITCHS         = 4;
VELOCITIES     = 5;
ONSET_SEC      = 6;
DURATION_SEC   = 7;
