%analyze features and performance parameters for the given score set
%performance parameter will not be analyzed for the 'play' set

function analyze(setName)
   settings

   disp('Reading Midis...')
   trainSamples = readMidis(midiPath, setName);
   disp('Preprocessing Midis...')
   if melodyOnly
      trainMelodies= getMelodies(trainSamples);
   end
   trainScores = quantizeAll(trainMelodies);


   disp('Analyzing Note Features...')
   features = {};
   featNo= NextUsedFeat;
   %TODO currFeatorm= 0;
   featNo.getNext;
   while ~featNo.isEnd
      %if debug_mode
      %   disp(featNo.currFeat);
      %end
      feature= getFeat(featNo.currFeat, trainScores)
      features{end +1 }= feature;

      featNo.getNext;
   end
%   if useFeature(1)
%      posInPhrase= getPosInPhrase(trainScores);
%      features{end +1 }  = posInPhrase
%      %features  = collectFeatures(posInPhrase, features);
%      %features = [features posInPhrase]; %errors here, posInPhrase is a cell
%   %   featureNames{end+1}= 'posInPhrase';
%   end
      


   disp('Analyzing Performances...')
   performParams  = {};
   if strcmp(setName, 'play')
      %do nothing
   else
      perfNo= NextUsedPerf;
      %TODO currPerform= 0;
      perfNo.getNext;
      while ~perfNo.isEnd
         perfParam = getPerform(perfNo.currPerf, trainMelodies, trainScores);
         performParams {end +1 }= perfParam;

         perfNo.getNext;
      end


%      if usePerform(1)
%         timeBias = getTimeBias(trainMelodies, trainScores);
%         performParams {end +1 }= timeBias;
%         %performParams= collectFeatures(timeBias,  performances);
%         %performances  = collectFeatures(timeBias,  performances);
%         %performs= [performs timeBias];
%         %performNames{end+1}= 'timeBias';
%      %loudness
%      end
%      if usePerform(2)
%         loudness = getLoudness(trainMelodies, trainScores);
%         performParams {end +1 }= loudness;
%         %performParams= collectFeatures(timeBias,  performances);
%         %performances  = collectFeatures(timeBias,  performances);
%         %performs= [performs timeBias];
%         %performNames{end+1}= 'timeBias';
%      %loudness
%      end
   end


   %proof of concept, will be refactor to modeling.m
   %scatter(posInPhrase{1}, timeBias{ 1 }) ;
   outFname = [setName '.mat'];
   save(outFname, 'features',  'performParams' )
   disp(['File ' outFname ' saved.']);
   disp('DONE')

end
