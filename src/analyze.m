settings

nmats = { };
for i = 1: size(trainList,2)
   disp( trainList{i} );
   %nmats{ end +1 }= readmidi(trainList(i)); %mex version
   nmats{ end +1 }= midi2nmat(trainList{i});%no mex version
end

