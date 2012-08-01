   settings
   setName = 'sample'; 

   disp('Reading Midis...')
   trainSamples = readMidis(midiPath, setName);
   disp('Preprocessing Midis...')
   if melodyOnly
      trainMelodies= getMelodies(trainSamples);
   end
   trainScores = quantizeAll(trainMelodies);

   disp('Analyzing Performances...')
   performParams  = {};
   if strcmp(setName, 'play')
      %do nothing
   else
      perf= UsedPerf;
      %TODO currPerform= 0;
      while ~perf.isEnd
         disp(perf.currPerf)
         perfParam = perf.get(trainMelodies, trainScores);
         performParams {end +1 }= perfParam;

         perf.next;
      end
   end

   disp(performParams{1}{1})

   %pianoroll(trainScores{1})
