#!/bin/bash
#required package: timidity, lame, vorbis-tools
if [ -z "$1" ] #check if input arg is empty
then 
   echo "Convert all midis in a folder to mp3"
   echo "Usage: mid2mp3.sh <dir>"
   exit 0 
fi
for midName in $(ls $1*.mid):
do
   echo "Converted " + $midName
   mp3Name=$midName.mp3
   #midi -> timidit -> wav -+-> oggenc -> ogg
   #                        |
   #                        +-> lame   -> mp3
   #timidity $midName -Ow -o - |tee >(oggenc - -o $oggName) |lame -h -f -b 64 - $mp3Name
   timidity $midName -Ow -o - |lame -h -f -b 64 - $mp3Name
done
