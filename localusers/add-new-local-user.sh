#!/usr/bin/env bash

# User must be executing with root privileges; if not, exit 1
if [[ "${UID}" -eq 0 ]]
then
  echo 'Good. You are root.'
else
  echo 'Sorry! You are not root!'
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
NUMBER_OF_PARAMETERS="${#}"
if [[ ${NUMBER_OF_PARAMETERS} -lt 2 ]]
then
  echo "Usage: ${0} USER_NAME [FULL NAME]..."
  exit 1
fi

# The first parameter is the USER_NAME
USER_NAME=${1}

# The rest of the parameters are for the account comments.
COMMENT=${@:2}

# Generate a password.
PASSWORD=$(date +%s%N | sha256sum | head -c8)


# Creates a new user on the local system 
useradd -c "${COMMENT}" -m ${USER_NAME}


# Check to see if useradd command succeeded
if $( echo ${?} | grep 1 )
then
  echo "Sorry, there was an error in adding this username."
  exit 1
fi


# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}


# Check to see if the passwd command succeeded
if $( echo ${?} | grep 1 )
then
  echo "Sorry, there was an error in setting this password."
  exit 1
fi


# Force password change on first login
passwd -e ${USER_NAME}


# Show error if any failures to this point
if $( echo ${?} | grep 1 )
then
  echo "Sorry, there was an error in expiring this password."
  exit 1
fi


# If we made it this far, display username, password, and host where account was
# created.  This the help desk staff can copy the output to easily deliver the
# information to the new account holder.
echo
echo
echo "username: "
echo "${USER_NAME}"
echo
echo "password: "
echo "${PASSWORD}"
echo
echo "host: "
echo $(hostname)
exit 0








