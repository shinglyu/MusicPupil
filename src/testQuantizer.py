from quantizer import *

testInput = {
               'feat1':[2,43,54,62,39,2,3,5,2,3,5,87,3],
               'feat2':[2.43525,3.243,-3.234,5.383,-8.39287]
            }

for key, val in testInput.items():
   q = getQuantizerObj('../output/testQuantizer.'+ key +'.json')
   print(val)
   codes = q.quantize(val)
   print(codes)
   reconsts = q.dequantize(codes)
   print(reconsts)
   print([abs(x-y) for x,y in zip(val, reconsts)])


