%write scores to midis
%output midis based on play.txt

function writeMidis(exprScores)
   settings; %midiPath
   fid = fopen([midiPath 'play.txt']);
   line= fgetl(fid);
   namelist = { };
   while ischar(line)
      namelist{end+1}= [outPath 'out_' line];
      line = fgetl(fid);
      %disp(fname);
   end
   nmats = { };
   for i = 1: size(namelist,2)
      disp( namelist{i} );
      %nmats{ end +1 }= readmidi(trainList(i)); %mex version
      nmats{ end +1 }= nmat2midi(exprScores{i}, namelist{i});%no mex version
   end

end
