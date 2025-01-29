#!/bin/bash

<< TASK
Create a switch statement.
TASK

read -p "Give commands to handle server:  " COMMAND

case "${COMMAND}" in
	start) 
		echo "Starting...."
		;;
	restart) 
		echo "Restarting.."
		;;
	stop) 
		echo "Stopping.."
		;;
	*)
		echo "Please give correct command."
		exit 1
esac



