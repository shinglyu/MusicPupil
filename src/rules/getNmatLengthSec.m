function length = getNmatLengthSec(nmat)
   settings;
   assert(size(nmat,2) == DURATION_SEC, 'Invalid NMAT format.');
   assert(size(nmat,3) == 1, 'Invalid NMAT format.');
   length = nmat(end, ONSET_SEC) + nmat(end, DURATION_SEC);
end
