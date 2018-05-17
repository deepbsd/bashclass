#!/usr/bin/env bash

# Display UID and username of the user executing the script
# Display if user is root or not

# Display the UID
USER_ID=$(id -u)
#echo "Your UID is ${UID}"


# Display the username
USER_NAME=$(whoami)
echo "Hello ${USER_NAME}! Your user id is ${USER_ID}!"


# Display if user is root or not
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi



