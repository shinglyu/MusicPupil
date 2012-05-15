%analyze features and performance parameters for the given score set
%performance parameter will not be analyzed for the 'play' set


   settings
   setName = 'sample'; 

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
      feature= getFeat(featNo.currFeat, trainScores)
      features{end +1 }= feature;

      featNo.getNext;
   end
   disp(features{1})
   pianoroll(trainScores{1})
