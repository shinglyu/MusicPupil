%read midis from fname txt file list 
%output cell array of nmats
function [nmats metadata]= readMidisFromList(list)
   settings
   nmats = {};
   metadata = {};
   for fno = 1:length(list)
      %fid = fopen([midiPath list(fno)]);
      fname = [midiPath list{fno}];
%      if debug_mode
%         disp(fname)
%      end
      nmats{ end +1 }= readmidi_java(fname);%no mex version
      metadata{end +1 } = readMeta(fname);
   end
end
