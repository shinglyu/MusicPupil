prefix=output20130720
for folder in $(ls -d $prefix*)
do
    ./mid2mp3.sh $folder/
    #echo $folder
done
