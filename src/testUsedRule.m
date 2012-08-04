settings
setName = 'play'; 


list = getFileList(setName);
[nmats, metadata] = readMidisFromList(list);
origNmats = nmats;



rules = UsedRule;

while ~rules.isEnd
   disp(rules.currRule)
   nmats = rules.apply(nmats, metadata);
   rules.next;
end
   dif = nmats{1} - origNmats{1};
   disp('original score')
   disp(origNmats{1})
   disp('input/output difference')
   disp(dif)
   if size(find(dif ~= 0)) > 0
      disp('Input and Output is different.')
   end

   
