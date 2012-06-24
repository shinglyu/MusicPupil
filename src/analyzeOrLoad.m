function [features, performParams] = analyzeOrLoad(setName)
   settings
   fprintf('Dataset:%s...', setName)
   list = getFileList(setName);

   fname = [midiPath list{1} '.ana.mat'];
   if exist(fname) 
      fprintf('Loading from existing analyze reaults...')
      score = load(fname);

      featCount = length(score.feature);
      perfCount = length(score.performParam);
      listCount = length(list);
      features= cell(1,featCount);
      performParams = cell(1, perfCount);
      for featNo = 1:featCount features{featNo} = cell(1, listCount); end
      for perfNo = 1:perfCount performParams{perfNo} = cell(1, listCount); end

      for fno = 1:listCount
         fname = [midiPath list{fno} '.ana.mat'];
         if exist(fname) 
            score = load(fname);
            for featNo = 1:featCount
               features{featNo}{fno} = score.feature{featNo};
            end
            for perfNo = 1:perfCount
               performParams{perfNo}{fno} = score.performParam{perfNo};
            end
         else
            [features, performParams] = analyze(setName);
         end
      end
      disp('DONE')
   else
      [features, performParams] = analyze(setName);
   end

   

%   for fno = 1:length(list)
%      fname = [list{fno} '.ana.mat'];
%      if exist(fname) 
%         score = load(fname);
%         for featNo = 1:length(score.feature)
%            features{featNo}{end +1} = score.feature{featNo};
%         end
%         for perfNo = 1:length(score.performParam)
%            performParams{end +1}{end +1} = score.performParam{featNo};
%         end
%      else
%         analyze(setName);
%         break;
%      end
%   end
%
