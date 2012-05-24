function list = getFileList(id)
   settings
   fname = [midiPath id '.txt'];
   list = importdata(fname);
end

