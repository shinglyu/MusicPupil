prefix=output20130812
for folder in $(ls -d $prefix*)
do
    ./mid2png.sh $folder/
    #echo $folder
done
