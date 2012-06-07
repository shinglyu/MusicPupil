settings
list = getFileList('sample');
[features, performances] = analyzeOrLoad('sample');

for sampNo = 1:length(list)
   for featNo = 1: length(features)
      for perfNo = 1: length(performances)
         figNo = (featNo-1)*length(performances) + perfNo;

         subplot(size(features, 2), size(performances, 2), figNo)
         %orderFeat = sort(features(:,featNo));
         %$tmpPerform = polyval(param{featNo, perfNo},orderFeat );
         %tmpPerform = polyval(param{i},features(:,1) );
         %plot(features(:,1), performances(:,i), 'o', features(:,1), tmpPerform, '-');
         %scatter(features(:,), performances(:,i), 'o', features(:,1), tmpPerform, '-');
         h = scatter(features{featNo}{sampNo}, performances{perfNo}{sampNo});
         xlabel(['Feature ' num2str(featNo)])
         ylabel(['Perform ' num2str(perfNo)])

         %plot(orderFeat, tmpPerform, '-');
      end 
   end 
   [path, name, ext] = fileparts(list{sampNo});
   saveas(h, [midiPath name], 'eps');
end
