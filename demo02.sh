#!/bin/bash

<< TASK
Exploring different ways of generating passwords.
TASK

#We will use RANDOM method to generate password
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

#Using RANDOM multiple times to make the password more complex
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

#We will use date method to generate password or can be also used a timestamp.
PASSWORD="$(date +%s)" #%s - the number of seconds till today after 1970.
echo "${PASSWORD}"

#We can use nanosecond to make password more complex.
PASSWORD="$(date +%s%N)"
echo "${PASSWORD}"

#A more better password using checksum methods
PASSWORD="$(date +%s | sha256sum | head -c9)"
echo "${PASSWORD}"

#More better
PASSWORD="$(date +%s${RANDOM}${RANDOM} | sha256sum | head -c48)"
echo "${PASSWORD}"


#We can add special character at the end.
SPECIAL_CHAR="$(echo '!@#$%^&*()_+=' | fold -w1 | shuf -n1)"
echo "${PASSWORD}${SPECIAL_CHAR}"



<< NOTES
List of cryptographic hash functions to verify the inigrity of the file.
1. md5sum
2. sha1sum
3. sha224sum
4. sha256sum
5. sha512sum
6. cksum
7. b2sum
8. sum  

NOTES
