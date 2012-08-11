%settings
setName = 'test'; 

disp('Reading Midis...')
list = getFileList(setName);
[nmats, metadata] = readMidisFromList(list);
disp('Preprocessing Midis...')
if melodyOnly
   trainMelodies= getMelodies(nmats);
else
   trainMelodies = nmats;
end
trainScores = quantizeAll(trainMelodies);
tmpScore = trainScores{1};
disp(tmpScore(1:5, :))
length = getBeatInSec(tmpScore );
disp(['Beat length = ' num2str(length) ' sec'])

tmpScore = trainScores{2};
disp(tmpScore(1:5, :))
length = getBeatInSec(tmpScore );
disp(['Beat length = ' num2str(length) ' sec'])
