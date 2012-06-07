function feat = getRelaDurationNext(scores)
   for i = 1:length(scores)
      next = [scores{i}(2:end, 2); scores{i}(end, 2)];
      feat{i} = scores{i}(:, 2)./next;
   end
end
