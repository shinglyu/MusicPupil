%generate expressive performance from model
load('modelParam.mat'); %modelParam
load('play.mat'); %features
scores = readMidis(midiPath, 'play');
if melodyOnly
   scores = getMelodies(scores);
   writeMidis(scores, 'orig_')
end

if useRegression
   exprScores = playRegression(scores, modelParam, features);
else
   exprScores = scores;
end
   
writeMidis(exprScores, 'expr_');
