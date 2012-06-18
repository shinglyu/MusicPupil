function modelNo = getModelNo()
   settings
   tmpNo = find(useModel);
      assert((length(tmpNo) == 1),'Only one model can be selected, check settings.');
      modelNo = tmpNo;

end
