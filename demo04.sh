#!/bin/bash


<< TASK
Create a username on your host and force user to change password in first login.

TASK

# Check if the user creating username should be root.
if [[ "$(id -u)" -ne 0 ]];
then
	echo "Please login with root user or use sudo"
	exit 1
fi

# Enter username, fullname and password
read -p "Enter username: " USERNAME

read -p "Enter fullname for the user: " COMMENT

read -p  "Enter password: " PASSWORD

# Create user
useradd -c "${COMMENT}" "${USERNAME}"

# Check if the user was created.
if [[ "${?}" -ne 0 ]];
then 
	echo "User not created successfully."
	exit 1
fi

# Add password for the user
echo "${USERNAME}:${PASSWORD}" | sudo chpasswd

# Expire password to change on first login
passwd -e "${USERNAME}"


# Display all the information once the user is created.
echo
echo "Username : ${USERNAME}"
echo
echo "Full Name : ${COMMENT}"
echo
echo "Password : ${PASSWORD}"
echo

exit 0
