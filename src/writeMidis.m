%write scores to midis
%output midis based on play.txt

function writeMidis(exprScores, prefix)
   settings; %midiPath
   fid = fopen([midiPath 'play.txt']);
   line= fgetl(fid);
   namelist = { };
   while ischar(line)
      namelist{end+1}= [outPath prefix line];
      line = fgetl(fid);
      %disp(fname);
   end
   nmats = { };
   for i = 1: size(namelist,2)
      disp( namelist{i} );
      %nmats{ end +1 }= readmidi(trainList(i)); %mex version
      %nmats{ end +1 }= nmat2midi(exprScores{i}, namelist{i}, defaultTempo);%no mex version
      %nmat2midi(exprScores{i}, namelist{i}, defaultTempo);%no mex version
      writemidi_java(exprScores{i}, namelist{i}, defaultTempo);%no mex version
   end
   %system('cd ../out; sh midi2wav.sh')%convert midi to wave

end
