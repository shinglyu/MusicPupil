settings
setName = 'play'; 


list = getFileList(setName);
[nmats, metadata] = readMidisFromList(list);
origNmats = nmats;



rules = UsedRule;

while ~rules.isEnd
   rules.next();
   nmats = rules.apply(nmats, metadata);
end
   dif = nmats{1} - origNmats{1};
   find(dif ~= 0)

   
