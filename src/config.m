addpath('../lib/miditoolbox)
%list of training samples
samplePath = '../audio/human_played_midi/KV310'
trainList = []
for i = 1:3
   fname = sprintf('phrase%03i', i);
   trainList = [trainList [samplePath fname]];


