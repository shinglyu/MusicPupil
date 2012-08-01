%analyze features and performance parameters for the given score set
%performance parameter will not be analyzed for the 'play' set

function [features, performParams] = analyze(setName)
   settings

   %disp('Reading Midis...')
   list = getFileList(setName);
   [nmats, metadata] = readMidisFromList(list);

   %nmats = readMidis(midiPath, setName);
   %disp('Preprocessing Midis...')
   if melodyOnly
      trainMelodies= getMelodies(nmats);
   end
   trainScores = quantizeAll(trainMelodies);


   fprintf('Analyzing Note Features...')
   features = {};
   feat= UsedFeat;
   %TODO currFeatorm= 0;
   while ~feat.isEnd
      %if debug_mode
      %   disp(feat.currFeat);
      %end
      feature= feat.get(trainScores, metadata);
      features{end +1 }= feature;
      feat.next();
   end

   performParams  = {};
   if strcmp(setName, 'play')
      %do nothing
   else
      fprintf('Analyzing Performances...')
      perf= UsedPerf;
      %TODO currPerform= 0;
      while ~perf.isEnd
         perfParam = perf.get(trainMelodies, trainScores);
         performParams {end +1 }= perfParam;

         perf.next();
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
