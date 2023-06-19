#Banker's Algorithm : Deadlock Avoidance Algorithm
echo -e "\n *** Banker's Algorithm : Deadlock Avoidance Algorithm *** \n"

## Constant Input ###------------------------------------
# #Create 2D Matrix of Allocation with constant values
# declare -A alloc
# alloc[0,0]=0 alloc[0,1]=1 alloc[0,2]=0
# alloc[1,0]=2 alloc[1,1]=0 alloc[1,2]=0
# alloc[2,0]=3 alloc[2,1]=0 alloc[2,2]=2
# alloc[3,0]=2 alloc[3,1]=1 alloc[3,2]=1
# alloc[4,0]=0 alloc[4,1]=0 alloc[4,2]=2

# #Create 2D Matrix of Max with constant values
# declare -A max
# max[0,0]=7 max[0,1]=5 max[0,2]=3
# max[1,0]=3 max[1,1]=2 max[1,2]=2
# max[2,0]=9 max[2,1]=0 max[2,2]=2
# max[3,0]=2 max[3,1]=2 max[3,2]=2
# max[4,0]=4 max[4,1]=3 max[4,2]=3

# #Create 2D Matrix of Available with constant values
# declare -a avail
# avail[0]=3 avail[1]=3 avail[2]=2

# # n - Number of Processes
# n=5
# # m - Number of Resources
# m=3

####--------------------------------------/

## Input from user -----------------------------
echo -e "Enter the number of processes : \c"
read n
echo -e "Enter the number of resources : \c"
read m

#Create 2D Matrix of Allocation
declare -A alloc
#Create 2D Matrix of Max
declare -A max

#Declare 1D Array of Available
declare -a avail

#Input Allocation Matrix
echo -e "Enter Space Separated Following Matrix! \n\n"

echo -e "Allocation Matrix : \n"
for((i=0;i<n;i++))
do  
    declare -a row
    read -a row

    for((j=0;j<m;j++))
    do
        alloc[$i,$j]=${row[$j]}
    done
done

#Input Max Matrix
echo -e "\nMax Matrix : \n"
for((i=0;i<n;i++))
do  
    declare -a row
    read -a row

    for((j=0;j<m;j++))
    do
        max[$i,$j]=${row[$j]}
    done
done
###----------------------------------------------------//

# #Input Available Matrix
echo -e "\nAvailable Matrix : \n"
read -a avail

#Create 2D Matrix of Need 
declare -A need
for((i=0;i<n;i++))
do
    for((j=0;j<m;j++))
    do
        need[$i,$j]=$((${max[$i,$j]}-${alloc[$i,$j]}))
    done
done

#Safe Sequence
declare -a safeSeq
safeidx=0

#Visited Array
declare -a visited

#Initialize all processes as not visited
for((i=0;i<n;i++))
do
    visited[$i]=0
done

#Traverse through all the processes
for((i=0;i<n;i++))
do
    flag=0 #Flag to check any one process can be allocated or not

    for((j=0;j<n;j++))
    do
        if [ ${visited[$j]} -eq 0 ] #If process is not visited
        then
            possible=1 #Flag to check if process can be allocated or not
            for((k=0;k<m;k++))
            do
                if [ ${need[$j,$k]} -gt ${avail[$k]} ] #If need is greater than available
                then
                    possible=0
                    break
                fi
            done

            if [ $possible -eq 1 ] #If process can be allocated
            then
                flag=1 #Mark flag as 1
                visited[$j]=1 #Mark process as visited
                safeSeq[$safeidx]=$j #Add process to safe sequence
                safeidx=$(($safeidx+1)) #Increment safe sequence index

                #Adding the free resources to available resources
                for((k=0;k<m;k++))
                do
                    avail[$k]=$((${avail[$k]}+${alloc[$j,$k]}))
                done
            fi
        fi
    
    done

    #If no process can be allocated
    if [ $flag -eq 0 ] 
    then
        break
    fi
    
done


#Check if all processes are visited or not
for((i=0;i<n;i++))
do
    if [ ${visited[$i]} -eq 0 ] #If process is not visited
    then
        echo -e "\n System is in unsafe state! \n"
        exit
    fi
done

echo -e "\n System is in safe state! \n"
echo -n " Safe Sequence is : "
for((i=0;i<n;i++))
do
    echo -n "P${safeSeq[$i]} "
done






