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

   modelNo = getModelNo();
   if modelNo == 1 
      exprScores = playRegression(scores, modelParam, features);
   elseif modelNo == 2 
      exprScores = playSingleRegress(scores, modelParam, features);
   elseif modelNo == 3 
      exprScores = playMultiRegress(scores, modelParam, features);
   else
      warning('No model applied');
      exprScores = scores;
   end
      
   writeMidis(exprScores, 'expr_');
   disp('')
   disp('DONE')
end
