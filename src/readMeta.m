function meta = readMeta(fname)
   settings
   fullFname = ([midiPath fname '.meta.txt']);
   if debug_mode
      disp(fullFname)
   end
   %importdata(fname)

   fid = fopen(fullFname);
   if fid < 0
      error(['File ' fullFname ' not found'])
   end


   line= fgetl(fid);
   while ischar(line) && ~isempty(line)
      %[fieldNames{end+1} fieldValues{end+1}]= strread(line ,'%s %f');
      [fieldName fieldValue]= strread(line ,'%s %f');
      if debug_mode
         [fieldName fieldValue]
      end
      meta.(fieldName{1}) = fieldValue;
      line = fgetl(fid);
   end
   


end
