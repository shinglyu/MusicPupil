function feat = getRelaDurationPrev(scores)
   for i = 1:length(scores)
      prev = [scores{i}(1, 2); scores{i}(1:end-1, 2)];
      feat{i} = scores{i}(:, 2)./prev;
   end
end
