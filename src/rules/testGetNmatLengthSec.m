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
disp(tmpScore(end-5:end, :))
length = getNmatLengthSec(tmpScore );
disp(['length = ' num2str(length)])

tmpScore = trainScores{2};
disp(tmpScore(end-5:end, :))
length = getNmatLengthSec(tmpScore );
disp(['length = ' num2str(length)])
