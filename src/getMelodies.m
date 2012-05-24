%reserve only highest pitches of namts
function melodies= getMelodies(nmats);
   for i = 1: length(nmats)
      melodies{i} = extreme(nmats{i}, 'high');

      if ~ismonophonic(melodies{i})
         currTime = 0;
         tmpMelody = [];
         for noteNo = 1:size(melodies{i}, 1) 
            if melodies{i}(noteNo, 1) >= currTime
               tmpMelody = [tmpMelody; melodies{i}(noteNo,:)];
               currTime = melodies{i}(noteNo, 1) + melodies{i}(noteNo, 2);
               %melodies{i}(noteNo, :) = [];
            end
         end
         melodies{i} = tmpMelody;
      end

      assert(ismonophonic(melodies{i}) == 1, 'Melody Extraction failed')
   end
end
