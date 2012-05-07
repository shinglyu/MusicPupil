%generate expressive performance from model
load('modelParam.mat'); %modelParam
load('play.mat'); %features
scores = readMidis(midiPath, 'play');

if useRegression
   exprScores = playRegression(scores, modelParam, features);
else
   exprScores = scores;
end
   
writeMidis(exprScores);
