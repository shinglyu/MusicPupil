
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




feats = UsedFeat;

while ~feats.isEnd
   disp(feats.currFeat)
   feature = feats.get(trainScores, metadata)
   feats.next;
end


   
