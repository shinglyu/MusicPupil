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
   find(dif ~= 0)

   
