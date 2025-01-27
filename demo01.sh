#!/bin/bash

<< TASK
Check if the current user is ROOT user or not.
TASK

# We will be using if statement
if [[ "$(id -u)" -ne 0 ]];
then 
	echo "You are not a ROOT user"
	exit 1
else
	echo "You are a ROOT user"
	exit 0
fi



