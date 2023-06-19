echo -n "Enter 3 numbers: "
read a b c

if [ $a -gt $b ] && [ $a -gt $c ] 
    then echo "Greatest number is: $a" 

elif [ $b -gt $a ] && [ $b -gt $c ] 
    then echo "Greatest number is: $b"
else
    echo "Greatest number is: $c"
fi
