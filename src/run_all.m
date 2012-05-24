settings
system('sh ../clean.sh');
getTrainingSet;
playList = getFileList('play');
playFeats = analyze('play');

fprinf('\n')
for fno = 1:length(playList)
   infoline = ['=====' playList{fno}];
   for i = 1:(50-length(infoline)) infoline = [infoline '=']; end
   disp(infoline)
   
   playSetName = [playList{fno} '.sim'];
%   if debug_mode
%      disp(playSetName)
%   end
   [features, performs] =  analyze(playSetName);
   modelParams = modeling(features, performs);
   play(modelParams, playFeats);
   fprintf('==================================================\n\n')
   
end
%analyze('sample')
%modeling
%analyze('play')
%play
%system('cd ../out; sh midi2wav.sh')%convert midi to wave
%system('sh ../out/midi2wav.sh')
