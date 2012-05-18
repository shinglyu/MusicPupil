%generate expressive performance from model
load('modelParam.mat'); %modelParam
load('play.mat'); %features
scores = readMidis(midiPath, 'play');
if playMelodyOnly
   scores = getMelodies(scores);
end
   writeMidis(scores, 'orig_')

%concatedFeats = concatinateFeatures(features);

if useRegression
   exprScores = playRegression(scores, modelParam, features);
else
   warning('No model applied');
   exprScores = scores;
end
   
writeMidis(exprScores, 'expr_');
