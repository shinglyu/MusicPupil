settings
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

outScore = alterDuration(tmpScore, 2, 1.5);
differ = outScore - tmpScore;
disp(differ)
assert(differ(2, DURATION_SEC) > 0)
assert(differ(2, ONSET_SEC) == 0)
assert(differ(3, ONSET_SEC) > 0)
assert(differ(3, DURATION_SEC) < 0)

disp('=================================')

outScore = alterDuration(tmpScore, 2, 0.8);
differ = outScore - tmpScore;
disp(differ)
assert(differ(2, DURATION_SEC) < 0)
assert(differ(2, ONSET_SEC) == 0)
assert(differ(3, ONSET_SEC) == 0)
assert(differ(3, DURATION_SEC) == 0)
