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
      perfNo= NextUsedPerf;
      %TODO currPerform= 0;
      perfNo.getNext;
      while ~perfNo.isEnd
         perfParam = getPerform(perfNo.currPerf, trainMelodies, trainScores);
         performParams {end +1 }= perfParam;

         perfNo.getNext;
      end
   end

   disp(performParams{1}{1})

   play
   %pianoroll(trainScores{1})
