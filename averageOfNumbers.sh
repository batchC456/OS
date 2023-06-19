declare -a arr

echo "Enter the lenght of array n: "
read n

echo "Enter the elements of array: "
for (( i=0; i<n; i++ ))
do
    read arr[$i]
done


sum=0
for (( i=0; i<n; i++ ))
do
    sum=$((sum + arr[$i]))
done

avg=$((sum/n))

echo "Average of array is: $avg"

