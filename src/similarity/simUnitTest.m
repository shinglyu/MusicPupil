[playScores playFnames] = readMidis( midiPath, 'play');
[sampScores sampFnames] = readMidis( midiPath, 'sample');

%calcRank
sampScores = getMelodies(sampScores);
rank = calcRank(playScores{1}, sampScores{1})
rank = calcRank(playScores{1}, sampScores{2})
rank = calcRank(playScores{1}, sampScores{3})
rank = calcRank(playScores{1}, playScores{1})
assert(rank == 1)

%getSimilar
similarList = getSimilar(playScores{1}, sampScores, sampFnames)
for i = 1 : length(similarList)
   disp(similarList{i})
end

%getTrainingSet()

