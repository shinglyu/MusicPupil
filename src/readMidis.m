%read midis from fname txt file list 
%output cell array of nmats
function [nmats fnames] = readMidis(path, fname)
   fid = fopen([path fname '.txt']);
   line= fgetl(fid);
   trainList = { };
   while ischar(line)
      trainList{end+1}= [path line];
      line = fgetl(fid);
      %disp(fname);
   end
   nmats = { };
   fnames= { };
   for i = 1: size(trainList,2)
      disp( trainList{i} );
      fnames{end +1 } = trainList{i}
      %nmats{ end +1 }= readmidi(trainList(i)); %mex version
      %nmats{ end +1 }= midi2nmat(trainList{i});%no mex version
      nmats{ end +1 }= readmidi_java(trainList{i});%no mex version
      
   end

end
