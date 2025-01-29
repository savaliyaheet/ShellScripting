#!/bin/bash


<< TASK
Crate a greeting function
TASK


greet(){
	echo "Hello, ${1}. " 
}

greet ${1}
