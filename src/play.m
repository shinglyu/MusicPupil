%generate expressive performance from model
load('modelParams.mat');

origScores= readMidis(playPath, playName);

if doPosInPhrase
   posInPhrase= getPosInPhrase(origScores);
   features{end+1}  = posInPhrase;
end

if useRegression
   exprScores = playRegression(origScores, param, features);
end
   
writeMidis(expPerforms);
