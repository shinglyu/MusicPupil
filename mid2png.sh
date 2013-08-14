#!/bin/bash
#required package: musescore
if [ -z "$1" ] #check if input arg is empty
then 
   echo "Convert all midis in a folder to mp3"
   echo "Usage: mid2mp3.sh <dir>"
   exit 0 
fi
for midName in $(ls $1*.mid):
do
   echo "Converted " + $midName
   pngName=$midName.png
   #midi -> timidit -> wav -+-> oggenc -> ogg
   #                        |
   #                        +-> lame   -> mp3
   #timidity $midName -Ow -o - |tee >(oggenc - -o $oggName) |lame -h -f -b 64 - $mp3Name
   mscore $midName -o $pngName
done
