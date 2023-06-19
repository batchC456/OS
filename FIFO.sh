#FIFO (First In First Out) - Page Replacement Algorithm
echo -e "\n ***FIFO Page Replacement Algorithm*** \n"

#Constant Inputs -> For Testing
# refstr=('a' 'b' 'c' 'd' 'c' 'a' 'd' 'b' 'e' 'b' 'a' 'b' 'c' 'd')
# fs=4

#Taking Inputs: 
# Reference String -> Character Array
echo -n "Enter space seperated Reference String: "
read -a refstr

#Number of Frames
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

#Initialize the pfarr with 0 and que with '-'
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

    #If the page is not in the Queue
    if [ $flag -eq 0 ]
    then
        #Increment the Page Fault Count
        pfcount=$(( pfcount + 1 ))

        #Set the Page Fault Array to 1
        pfarr[$i]=1

        #Increment the queue index
        qidx=$(( (qidx + 1) % fs ))

        #Add the current page to the queue
        que[$qidx]=${refstr[$i]}
    fi

    #Add Queue to the 2D Matrix 
    for (( j=0; j<fs; j++ ))
    do
        matrix[$i,$j]=${que[$j]}
    done

done


#Page Fault Percentage
pfper=$(( (pfcount * 100) / n ))

#Printing the Results
echo -e "\n\nResult:--------------------- \n"

echo "Frame Size: $fs"
echo "Total Number of Pages: $n"
echo "Total Number of Page Faults: $pfcount"
echo "Page Fault Percentage: $pfper%"
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










