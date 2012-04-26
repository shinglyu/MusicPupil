%reserve only highest pitches of namts
function melodies= getMelodies(nmats);
   for i = 1: length(nmats)
      melodies{i} = extreme(nmats{i}, 'high');
   end
end
