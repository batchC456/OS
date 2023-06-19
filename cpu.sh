echo "CPU Scheduling Program : " 
echo -n "Enter the length of array: "
read n

declare -a arr
declare -a bust

echo ""
echo "Enter the Arrival Time in Sorted Order: " 
for (( i=0; i<n; i++ ))
do
    read arr[$i]
done

echo ""
echo "Enter the corresponding Bust Time: " 
for (( i=0; i<n; i++ ))
do
    read bust[$i]
done

printf "\n\n"
printf "%5s. |  %10s  |  %10s  |  %10s | %10s | %10s | %10s | %10s |\n" "P.No"  "Arrival"  "Bust"  "Start"  "Completion"  "TAT"  "Waiting" "Response"
printf " -------------------------------------------------------------------------------------------------------\n"

st=$((arr[0]))

for(( i=0; i<n; i++ ))
do
    ct=$((st+bust[$i]))
    tat=$((ct-arr[$i]))
    wt=$((tat-bust[$i]))
    rt=$((st-arr[$i]))

    printf "%5d. |  %10d  |  %10d  |  %10d | %10d | %10d | %10d | %10d | \n" $((i+1)) ${arr[$i]} ${bust[$i]} $st $ct $tat $wt $rt

    if [ $i -lt $((n-1)) ]
    then 
        if [ ${arr[i+1]} -gt $ct ]
        then 
            st=${arr[i+1]}
        else
            st=$ct
        fi
    fi

done








