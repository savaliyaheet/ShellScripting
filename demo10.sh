#!/bin/bash

<< TASK
Take 2 numbers as input from user and add it and print the result
TASK

echo "Provide two number to perform addition"
echo
read -p "Number 1 : " a
read -p "Number 2 : " b

sum=$(( a + b ))
echo
echo "The total of ${a} and ${b} is ${sum}"
