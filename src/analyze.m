settings

disp('Reading Training Midis...')
trainSamples = readMidis(trainSamplePath, trainSampleName);
disp('Preprocessing Midis...')
trainMelodies= getMelodies(trainSamples);
trainScores = quantizeAll(trainMelodies);


disp('Analyzing Note Features...')
features = [];
if doPosInPhrase
   posInPhrase= getPosInPhrase(trainScores);
   features  = collectFeatures(posInPhrase, features);
   %features = [features posInPhrase]; %errors here, posInPhrase is a cell
%   featureNames{end+1}= 'posInPhrase';
end
   


disp('Analyzing Performances...')
performances = [];
if doTimeBias
   timeBias = getTimeBias(trainMelodies, trainScores);
   performances  = collectFeatures(timeBias,  performances);
   performances  = collectFeatures(timeBias,  performances);
   %performs= [performs timeBias];
   %performNames{end+1}= 'timeBias';
%loudness
end


%proof of concept, will be refactor to modeling.m
%scatter(posInPhrase{1}, timeBias{ 1 }) ;

save('analyzeOutput.mat', 'features',  'performances' )
disp('DONE')


