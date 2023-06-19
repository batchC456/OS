echo -n "Enter a number: " 
read num

f=1

if [ $num -le 1 ]
    then f=0
fi

for(( i=2; i<num; i++ )) 
do 
    if [ $((num%i)) -eq 0 ]
        then f=0
        break
    fi
done

if [ $f -eq 1 ] 
    then echo "Prime"
else
    echo "Not Prime"
fi



