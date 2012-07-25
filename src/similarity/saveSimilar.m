function saveSimilar(simList, fname)
   settings
   outfname = [ midiPath fname '.sim.txt'];
   fid = fopen(outfname, 'at'); %open as append
   assert(fid > 0, 'No such file')
   for i = 1:length(simList)
      fprintf(fid, '%s\n', simList{i});
      if debug_mode
         disp(simList{i});
      end
   end
   fclose(fid);
   %save(outfname, 'simList', '-ascii');
end
