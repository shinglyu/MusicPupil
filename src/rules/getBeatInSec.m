%get Average length of a beat in seconds
function beatLen = getBeatInSec(nmat)
   settings
   assert(size(nmat,2) == DURATION_SEC, 'Invalid NMAT format.');
   assert(size(nmat,3) == 1, 'Invalid NMAT format.');
   assert(size(nmat,1) > 0, 'NMAT too short');
   beatLens = nmat(:, DURATION_SEC)./nmat(:, DURATION_BEATS);
   beatLen = mean(beatLens);
end
