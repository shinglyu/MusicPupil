%write scores to midis
%output midis based on play.txt

function writeMidisFromList(exprScores,list,  prefix)
   settings; %midiPath
   assert(length(exprScores) == length(list), 'Mismatched exprScore and fileNameList')
   for fno = 1:length(list)
      %fid = fopen([midiPath list(fno)]);
      fname = [outPath list{fno}];
%      if debug_mode
%         disp(fname)
%      end
      writemidi_seconds(exprScores{fno}, fname);%no mex version
   end
   %system('cd ../out; sh midi2wav.sh')%convert midi to wave

end
