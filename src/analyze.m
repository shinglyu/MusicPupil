%analyze features and performance parameters for the given score set
%performance parameter will not be analyzed for the 'play' set

function [features, performParams] = analyze(setName)
   settings

   %disp('Reading Midis...')
   list = getFileList(setName);
   nmats = readMidisFromList(list);

   %nmats = readMidis(midiPath, setName);
   %disp('Preprocessing Midis...')
   if melodyOnly
      trainMelodies= getMelodies(nmats);
   end
   trainScores = quantizeAll(trainMelodies);


   fprintf('Analyzing Note Features...')
   features = {};
   featNo= NextUsedFeat;
   %TODO currFeatorm= 0;
   featNo.getNext;
   while ~featNo.isEnd
      %if debug_mode
      %   disp(featNo.currFeat);
      %end
      feature= getFeat(featNo.currFeat, trainScores);
      features{end +1 }= feature;

      featNo.getNext;
   end

   performParams  = {};
   if strcmp(setName, 'play')
      %do nothing
   else
      fprintf('Analyzing Performances...')
      perfNo= NextUsedPerf;
      %TODO currPerform= 0;
      perfNo.getNext;
      while ~perfNo.isEnd
         perfParam = getPerform(perfNo.currPerf, trainMelodies, trainScores);
         performParams {end +1 }= perfParam;

         perfNo.getNext;
      end
   end

   feature = {};
   performParam = {};
   for fno = 1:length(list)
      fname = [midiPath list{fno} '.ana.mat'];
      for featNo = 1:length(features)
         feature{featNo} = features{featNo}{fno};
      end
      for perfNo = 1:length(performParams)
         performParam{perfNo} = performParams{perfNo}{fno};
      end
      save(fname, 'feature', 'performParam')
   end

   %proof of concept, will be refactor to modeling.m
   %scatter(posInPhrase{1}, timeBias{ 1 }) ;
   %outFname = [setName '.mat'];
   %save(outFname, 'features',  'performParams' )
   %disp(['File ' outFname ' saved.']);
   disp('DONE')

end
