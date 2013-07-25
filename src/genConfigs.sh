prefix=3
for i in 1 2 3 4 5 6 
do
    id=$prefix$i
    cp config.py config_$id.py
done
