%analyze features and performance parameters for the given score set
%performance parameter will not be analyzed for the 'play' set

function analyze(setName)
   settings

   disp('Reading Midis...')
   trainSamples = readMidis(midiPath, setName);
   disp('Preprocessing Midis...')
   trainMelodies= getMelodies(trainSamples);
   trainScores = quantizeAll(trainMelodies);


   disp('Analyzing Note Features...')
   features = {};
   if useFeature(1)
      posInPhrase= getPosInPhrase(trainScores);
      features{end +1 }  = posInPhrase
      %features  = collectFeatures(posInPhrase, features);
      %features = [features posInPhrase]; %errors here, posInPhrase is a cell
   %   featureNames{end+1}= 'posInPhrase';
   end
      


   disp('Analyzing Performances...')
   performParams  = {};
   if strcmp(setName, 'play')
      %do nothing
   else
      if usePerform(1)
         timeBias = getTimeBias(trainMelodies, trainScores);
         performParams {end +1 }= timeBias;
         %performParams= collectFeatures(timeBias,  performances);
         %performances  = collectFeatures(timeBias,  performances);
         %performs= [performs timeBias];
         %performNames{end+1}= 'timeBias';
      %loudness
      end
   end


   %proof of concept, will be refactor to modeling.m
   %scatter(posInPhrase{1}, timeBias{ 1 }) ;
   outFname = [setName '.mat'];
   save(outFname, 'features',  'performParams' )
   disp(['File ' outFname ' saved.']);
   disp('DONE')

end
