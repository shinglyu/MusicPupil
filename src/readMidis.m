%read midis from fname txt file list 
%output cell array of nmats
function nmats = readMidis(path, fname)
   fid = fopen([path fname]);
   line= fgetl(fid);
   trainList = { };
   while ischar(line)
      trainList{end+1}= [path line];
      line = fgetl(fid);
      %disp(fname);
   end
   nmats = { };
   for i = 1: size(trainList,2)
      disp( trainList{i} );
      %nmats{ end +1 }= readmidi(trainList(i)); %mex version
      nmats{ end +1 }= midi2nmat(trainList{i});%no mex version
   end

end
