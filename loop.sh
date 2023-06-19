# While Loop
i=0
while [ $i -le 10 ]
    do echo "i is: $i"
    ((i++))
done

# For Loop
for(( j=0; j<=10; j++ ))
    do echo "j is: $j"
done