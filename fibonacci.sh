echo -n "Enter number: "
read n

a=0
b=1
c=1

echo -n "$n terms of Fibonacci Series are: "

for(( i=2; i<=n+1; i++ ))
do
    echo -n "$a "
    c=$((a+b))
    a=$b
    b=$c
done

