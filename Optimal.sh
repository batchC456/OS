#FIFO (First In First Out) - Page Replacement Algorithm
echo -e "\n ***Optimal Page Replacement Algorithm*** \n"

### Constant Inputs -> For Testing
## refstr=('a' 'b' 'c' 'd' 'c' 'a' 'd' 'b' 'e' 'b' 'a' 'b' 'c' 'd')
## fs=4

### Taking Inputs: 
## Reference String -> Character Array
echo -n "Enter space seperated Reference String: "
read -a refstr

##Number of Frames
echo -n "Enter the Frame Size: "
read fs

#Length of Reference String
n=${#refstr[@]}

#2D Matrix to store the Queue
declare -A matrix

#Array to store the Page Faults 
declare -a pfarr 
#Page Fault Count
pfcount=0 

#Queue to store the FIFO
declare -a que
#Queue Index
qidx=-1

#Initialize the "pfarr" with 0 and "que" with '-'
for (( i=0; i<n; i++ ))
do
    pfarr[$i]=0
    que[$i]='-'
done


#Loop through the Reference String
for (( i=0; i<n; i++ ))
do
    #Check if the current page is already in the Queue
    flag=0
    for (( j=0; j<fs; j++ ))
    do
        if [ "${que[$j]}" == "${refstr[$i]}" ]
        then
            flag=1
            break
        fi
    done

    #If the page is not in the Queue!!!
    if [ $flag -eq 0 ]
    then
        #Increment the Page Fault Count
        pfcount=$(( pfcount + 1 ))

        #Set the Page Fault Array to 1
        pfarr[$i]=1

        #If the Queue is not full!!!
        if [ $qidx -lt $(( fs - 1 )) ]
        then
            #Increment the Queue Index
            qidx=$(( qidx + 1 ))

            #Add the Page to the Queue
            que[$qidx]=${refstr[$i]}
        

        #If the Queue is full!!!
        else
            #Find the Optimal Page to be replaced

            #Maximum Index Array
            declare -a maxidxarr

            #Maximum Index Array Index with -1
            for (( j=0; j<fs; j++ ))
            do
                maxidxarr[$j]=$n
            done

            #Loop through the Queue
            for (( j=0; j<fs; j++ ))
            do
                #Loop through the Reference String
                for (( k=i+1; k<n; k++ ))
                do
                    #If the page in the Queue is found in the Reference String
                    if [ "${que[$j]}" == "${refstr[$k]}" ]
                    then
                        #Store the index of the page in the maxidxarr
                        maxidxarr[$j]=$k
                        break
                    fi
                done
            done

            #Find the maximum index in the maxidxarr
            maxidx=-1
            pageidx=-1

            for (( j=0; j<fs; j++ ))
            do
                if [ ${maxidxarr[$j]} -gt $maxidx ]
                then
                    maxidx=${maxidxarr[$j]}
                    pageidx=$j
                fi
            done

            #Replace the page with the maximum index
            que[$pageidx]=${refstr[$i]}
            
        fi

    fi

    #Add Queue to the 2D Matrix 
    for (( j=0; j<fs; j++ ))
    do
        matrix[$i,$j]=${que[$j]}
    done

done


#Page Fault Percentage
pfprob=$(( (pfcount * 100) / n ))

#Printing the Results
echo -e "\n\nResult:--------------------- \n"

echo "Frame Size: $fs"
echo "Total Number of Pages: $n"
echo "Total Number of Page Faults: $pfcount"
echo "Page Fault Percentage: $pfprob%"
echo ""

#Printing Reference String
echo -n "The Reference String is: "
echo "${refstr[@]}"

#Printing Page Fault Array
echo -n "The Page Fault Array is: "
echo "${pfarr[@]}"


echo ""
echo "| Reference String | Page Fault | Queue |"
echo ""

for (( i=0; i<n; i++ ))
do
    echo -n "| ${refstr[$i]} | ${pfarr[$i]} | "
    for (( j=0; j<fs; j++ ))
    do
        echo -n "${matrix[$i,$j]} "
    done
    echo "|"
done










