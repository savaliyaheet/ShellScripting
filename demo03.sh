#!/bin/bash

<< TASK
Create password for each USERNAME passed through arguments.
TASK

#Check if arguments is atleast one.
if [[ "${#}" -lt 1 ]];
then
	echo "Enter atleast one username: ${0} USERNAME, [USERNAME], .."
	exit 1
fi

for USERNAME in "${@}"
do
	PASSWORD="$(date +%s%N | sha256sum | head -c24)"
	echo "${USERNAME} : ${PASSWORD}"
done

<< NOTE
${#} - To check number of arguments
${*} - To consider all arguements seperated as a single whole.
${@} - List all the arguements passed.
${?} - To check the exit status. (zero or non-zero)
NOTE
