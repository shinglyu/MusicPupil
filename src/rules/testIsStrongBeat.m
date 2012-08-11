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
disp(['Beats in a measure = ' num2str(metadata{1}.beatsInMeasure) ]);
isStrong= isStrongBeat(tmpScore, metadata{1} )

tmpScore = trainScores{2};
disp(['Beats in a measure = ' num2str(metadata{2}.beatsInMeasure) ]);
isStrong= isStrongBeat(tmpScore, metadata{1} )

