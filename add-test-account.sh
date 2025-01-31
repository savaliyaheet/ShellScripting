#!/bin/bash


# Adding test user 
for U in carrief markh harrisonf alecg peterm
do
	PASSWORD='pass123'
	sudo useradd -m ${U}
	echo "${U}:${PASSWORD}" | sudo chpasswd 
done
