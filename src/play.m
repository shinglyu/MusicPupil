%generate expressive performance from model
function play(modelParam, features)
   settings
   fprintf('Playing phrase...');
   %load('modelParam.mat'); %modelParam
   %load('play.mat'); %features

   list = getFileList('play');
   scores = readMidisFromList(list);
   %scores = readMidis(midiPath, 'play');
   if playMelodyOnly
      scores = getMelodies(scores);
   end
      writeMidis(scores, 'orig_');

   %concatedFeats = concatinateFeatures(features);

   if useRegression
      exprScores = playRegression(scores, modelParam, features);
   else
      warning('No model applied');
      exprScores = scores;
   end
      
   writeMidis(exprScores, 'expr_');
   disp('')
   disp('DONE')
end
