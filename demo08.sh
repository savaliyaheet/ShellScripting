#!/bin/bash


<< TASK
What is getopts and how to handle getops arguements. 

The getopts command in bash scripting is used to parse command-line options and arguments. It helps handle flags (-a, -b, etc.) and option values (-f filename) in shell scripts.
TASK

usage(){
	echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
        echo "Generate a random password."
	echo " -l LENGTH Specify the password length"
	echo " -v        Increase verbosity."
	echo " -s        Append special character to the password."
       	exit 1
}

log(){
	local MESSAGE=${@}
	if [[ "${VERBOSE}" = 'true' ]];
	then
		echo "${MESSAGE}"
	fi
}


#Set default length
LENGTH=48

while getopts vl:s OPTION
do
	case ${OPTION} in
		v)
			VERBOSE="true"
			log "Verbose mode enabled."
			;;
		s)
			SPECIAL_CHAR="true"
			;;
		l)
			LENGTH="${OPTARG}"
			;;
		?)
			usage
			;;
	esac
done

log "Generating a password."

PASSWORD="$(date +%s%N${RANDOM} | sha256sum | head -c${LENGTH})"

if [[ "${SPECIAL_CHAR}" = 'true' ]];
then
	log 'Selecting Special character..'
	CHARACTER="$(echo "!@#$%^&*()_+=" | fold -w1 | shuf | head -c1)"
	PASSWORD="${PASSWORD}${CHARACTER}"
fi

echo "${PASSWORD}"
exit 0
