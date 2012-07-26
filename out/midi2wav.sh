#!/bin/sh
for fname in *.mid;
do wavname=`echo $fname |sed 's/mid/wav/'`;
   mp3name=`echo $fname |sed 's/mid/mp3/'`;

   timidity $fname -Ow -o $wavname;
   lame -h $wavname $mp3name;

done;
rm *.wav;
mv *.mid midi_latest/
cp *.mp3 mp3_latest/
