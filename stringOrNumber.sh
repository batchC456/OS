echo "Enter a number or a string: "
read input

# Check if the input is a number or a string
if [[ $input =~ ^[0-9]+$ ]]; then
  echo "$input is a number"
else
  echo "$input is a string"
fi