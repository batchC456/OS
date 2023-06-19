printf "*** Priority Scheduling (Non-Preemtive): CPU Scheduling Algorithm! ***\n\n"
printf "Enter number of Processes: " 
read n;

INT_MAX=2147483647
declare -a arrival
declare -a burst
declare -a priority
declare -a visited

printf "\n Enter the follow space separated details: \n\n"
printf "| Arrival Time | Burst Time | Priority | \n"
printf " --------------------------------------- \n"

for (( i=0; i<n; i++))
do
    read arrival[$i] burst[$i] priority[$i]
    visited[$i]=0
done

#Finding First Minimum Arrival Time / Start Time
id=-1 startTime=$INT_MAX
for (( i=0; i<n; i++))
do
    if [ ${arrival[$i]} -lt $startTime ]
        then startTime=${arrival[$i]}
    fi
done


printf " \n Output: \n"
printf " -------------------------------------------------------------------------------------------- \n"
printf "| %3s | %8s | %8s | %8s | %8s | %10s | %4s | %8s | %8s | \n" "ID" "Arrival" "Burst" "Priority" "Start" "Completion" "TAT" "Waiting" "Response"
printf " -------------------------------------------------------------------------------------------- \n"

x=0

#Main Loop
while [ $x -lt $n ]
do

    maxPriority=$INT_MAX
    for (( i=0; i<n; i++ ))
    do
        if [ ${visited[$i]} -eq 0 ] && [ ${arrival[$i]} -le $startTime ] && [ ${priority[$i]} -lt $maxPriority ]
            then 
            maxPriority=${priority[$i]}
            id=$i
        fi
    done

    visited[$id]=1
    completionTime=$((startTime + ${burst[$id]}))
    turnAroundTime=$((completionTime - ${arrival[$id]}))
    waitingTime=$((turnAroundTime - ${burst[$id]}))
    responseTime=$((startTime - ${arrival[$id]}))

    printf "| %3s | %8s | %8s | %8s | %8s | %10s | %4s | %8s | %8s | \n" $(($id+1)) ${arrival[$id]} ${burst[$id]} ${priority[$id]} $startTime $completionTime $turnAroundTime $waitingTime $responseTime 

    startTime=$completionTime  
    x=$((x+1))

done

printf " -------------------------------------------------------------------------------------------- \n"



