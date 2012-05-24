function getTrainingSet()
   settings
   fprintf('Calculating similartiy and preparing training sets...')
   playList = getFileList('play');
   playScores = readMidisFromList(playList);
   sampList = getFileList('sample');
   sampScores = readMidisFromList(sampList);
   %[playScores playList] = readMidis(midiPath, 'play');
   %[sampScores sampList] = readMidis( midiPath, 'sample');
   playScores = getMelodies(playScores);
   sampScores = getMelodies(sampScores);

   %for each score
   %find top 10
   for scoreNo = 1:length(playScores)
      similarList = getSimilar(playScores{scoreNo}, sampScores, sampList);
      saveSimilar(similarList, playList{scoreNo})
   end
   %save output to midiPath/fname.txt
   fprintf('DONE\n')
end

