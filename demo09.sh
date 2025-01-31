#!/bin/bash


<< TASK
The goal of this exercise is to create a shell script that allows for a local Linux account to be disabled, deleted, and optionally archived.

SCENARIO:
Today the help desk team received a request to delete an account for a person who has changed departments.  This person doesn't have time to log into Linux systems -- they're in management now!
The help desk team also wants to save the contents of this person's home directory just in case this person returns to their original department and job.
They realize this is just going to be the first of these types of requests.  They know they're eventually going to receive requests to disable accounts for when people are on extended leave.

TASK

ARCHIVE_DIR='/archive'

#usage function
usage(){
	echo "Usage : ${0}: [-dra] USER [USERN] ..." >&2
	echo "Disable a local linux accont" >&2
	echo " -d  Delete account instead of disabling them." >&2	
	echo " -r  Remove home directories associated with the accunt" >&2
	echo " -a  Archiving the home directory associated with the account" >&2
	exit 1
}


# Check if user is root user or not
if [[ "$(id -u)" -ne 0 ]];
then
	echo "Please login with root user or use sudo command before exectuing script" >&2
	exit 1 
fi

#PARSE THE OPTIOBN
while getopts dra OPTION
do
	case "${OPTION}" in
		d) DELETE_USER='true' ;;
		r) REMOVE_OPTION='-r' ;;
		a) ARCHIVE='true' ;;
		?) usage ;;
	esac
done

# Remove options while leaving remaining arguements.
shift "$(( OPTIND - 1 ))"


# If user doesn't supply atleast one argument give them help.
if [[ "${#}" -lt 1 ]];
then
	usage
fi

# Loop through all the passed arguements

for USERNAME in "${@}"
do
	echo "Processing user : ${USERNAME}.."

	# CHECK if the userid is not less than 1000
	if [[ "$(id -u ${USERNAME})" -lt 1000 ]];
	then
		echo "User cannot be deleted. " >&2
		exit 1
	fi


	# Creating an archive if requested to do so.
	if [[ "${ARCHIVE}" = 'true' ]];
	then
		# Create archive directory doesn't exist one
		if [[ ! -d "${ARCHIVE_DIR}" ]];
		then
			echo "Creating an archive directoty: ${ARCHIVE_DIR}"
			mkdir -p "${ARCHIVE_DIR}"
		
			# Check if directory created successfully or not
			if [[ "${?}" -ne 0 ]];
			then
				echo "Something went wrong: Directory not created." >&2
				exit 1
			else
				echo "Directory ${ARCHIVE_DIR} created successfully."
			fi
		fi

		# Create the archive of the user's home directory and move it to the archive directory.
		HOME_DIR="/home/${USERNAME}"
		ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"
		
		# Check if home directory exist.
		if [[ -d "${HOME_DIR}" ]];
		then
			echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}.."
			tar -zcf "${ARCHIVE_FILE}" "${HOME_DIR}" &> /dev/null

			# Check if archive was created successfully.
			if [[ "${?}" -ne 0 ]];
                        then
                                echo "Something went wrong: ${ARCHIVE_FILE} not created." >&2
                                exit 1
                        else
                                echo "${ARCHIVE_FILE} created successfully."
                        fi
		else
			echo "${HOME_DIR} does not exist. " >&2
			exit 1
		fi	
			
	fi

	# Check if user wants to be deleted or not
	if [[ "${DELETE_USER}" = 'true' ]];
	then
		# Delete the user
		if [[ ! "${REMOVE_OPTION}" ]];
		then
			userdel "${USERNAME}"
		else	
			userdel "${REMOVE_OPTION}" "${USERNAME}"
		fi

		# Check if user was deleted or not.
		if [[ "${?}" -ne 0 ]];
                then
                        echo "Something went wrong: ${USERNAME} cannot be deleted." >&2
			exit 1
                else
			echo "${USERNAME} deleted successfully."
		fi
	else
		chage -E 0 "${USERNAME}"
		# Check is the user was disabled or not.
		if [[ "${?}" -ne 0 ]];
		then
			echo "Something went wrong: ${USERNAME} was not disabled." >&2
			exit 1
                else
                        echo "${USERNAME} disabled successfully."
		fi
	fi

done

exit 0

