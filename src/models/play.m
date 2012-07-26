%generate expressive performance from model
function play(modelParam, scoreName)
   settings
   fprintf('Playing phrase...');
   %load('modelParam.mat'); %modelParam
   %load('play.mat'); %features

   %list = getFileList('play');
   %score = readMidisFromList(list);
   %score = readMidis(midiPath, 'play');
   features = analyzeOrLoad(scoreName);
   list = getFileList(scoreName);
   [score metadata] = readMidisFromList(list);
   if playMelodyOnly
      score = getMelodies(score);
   end
      writeMidisFromList(score, list, 'orig_');

   %concatedFeats = concatinateFeatures(features);

   modelNo = getModelNo();
   if modelNo == 1 
      exprScores = playRegression(score, modelParam, features);
   elseif modelNo == 2 
      exprScores = playSingleRegress(score, modelParam, features);
   elseif modelNo == 3 
      exprScores = playMultiRegress(score, modelParam, features);
   else
      warning('No model applied');
      exprScores = score;
   end

   exprScores = playRule(exprScores, metadata);

   
      
   writeMidisFromList(exprScores, list,'expr_');
   disp('')
   disp('DONE')
end
