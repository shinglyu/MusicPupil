%quantize human played midi to get score
function score = quantizeAll(nmats);
   for i = 1: length(nmats)
      score{i} = quantize(nmats{i}, 1/8);
   end
end
