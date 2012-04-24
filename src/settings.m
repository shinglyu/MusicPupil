addpath('../lib/miditoolbox')
%list of training samples
%create a txt file containing all training sample filenames 
samplePath = '../audio/human_played_midi/KV310/';
fid = fopen([samplePath 'sampleList.txt']);
fname = fgetl(fid);
trainList = { };
while ischar(fname)
   trainList{end+1}= [samplePath fname];
   fname = fgetl(fid);
   %disp(fname);
end

%numOfSamples = 3;
%%samplePath = '/home/a108210/Dropbox/Courses/project/build/audio/human_played_midi/KV310/';
%samplePath = '../audio/human_played_midi/KV310/';
%trainList = { };
%for i = 1:numOfSamples
%   fname = sprintf('phrase%03i.mid', i);
%   trainList{end+1}= [samplePath fname];
%end

