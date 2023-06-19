printf "\n\n *** Round Robin CPU Scheduling Algorithm ***\n\n"

printf "Enter Time Quantum: "
read quantum

printf "Enter number of Processes: "
read n;

declare -a arrivalTime
declare -a burstTime

declare -a remainingTime
declare -a visited
declare -a completionTime
declare -a turnAroundTime
declare -a waitingTime

printf "\n Enter the follow space separated details: \n\n"
printf " | Arrival Time | Burst Time | \n"
printf " ----------------------------- \n"

for (( i=0; i<n; i++))
do
    read arrivalTime[$i] burstTime[$i]
    remainingTime[$i]=${burstTime[$i]}
    visited[$i]=0
    completionTime[$i]=0
    turnAroundTime[$i]=0
    waitingTime[$i]=0
done
printf " ----------------------------- \n"


time=${arrivalTime[0]}
count=0

declare -a q=()
q[0]=0
visited[0]=1

while [ $count -lt $n ]
do
    curr=${q[0]}
    time=$((time + $(($quantum < remainingTime[$curr] ? quantum : remainingTime[$curr]))))

    #Removing first element from the queue
    q=("${q[@]:1}")

    for (( i = 0; i < $n; i++ ))
    do
        if [ ${visited[$i]} -eq 0 ] && [ ${arrivalTime[$i]} -le $time ]
        then
            visited[$i]=1
            #Adding the process to the end of the queue
            q+=($i)
        fi
    done

    remainingTime[$curr]=$((remainingTime[$curr] - $((quantum < remainingTime[$curr] ? quantum : remainingTime[$curr]))))

    if [ ${remainingTime[$curr]} -eq 0 ]
    then
        visited[$curr]=1
        completionTime[$curr]=$time
        turnAroundTime[$curr]=$((completionTime[$curr] - arrivalTime[$curr]))
        waitingTime[$curr]=$((turnAroundTime[$curr] - burstTime[$curr]))
        count=$((count + 1))
    else
        #Adding the Current Process at the end of the queue
        q+=($curr)
    fi
done

# Printing the output

printf "\n\n"
printf "Abbreviations:\n"
printf "P.No: Process Number\n"
printf "AT: Arrival Time\n"
printf "BT: Burst Time\n"
printf "CT: Completion Time\n"
printf "TAT: Turn Around Time\n"
printf "WT: Waiting Time\n\n"

printf " ------------------------------------------------------------------- \n"
printf "| %5s | %8s | %8s | %8s | %10s | %10s | \n" "P.No:" "AT" "BT" "CT" "TAT" "WT"
printf " ------------------------------------------------------------------- \n"

for (( i = 0; i < $n; i++ ))
do
    printf "| %5d | %8d | %8d | %8d | %10d | %10d |\n" $((i + 1)) ${arrivalTime[$i]} ${burstTime[$i]} ${completionTime[$i]} ${turnAroundTime[$i]} ${waitingTime[$i]}
done

printf " ------------------------------------------------------------------- \n"

printf "\n Made By: Rahul Kumar (10714802720) \n"
