prefix=output20130812
for folder in $(ls -d $prefix*)
do
    ./mid2mp3.sh $folder/
    #echo $folder
done
