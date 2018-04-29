#!/usr/bin/env bash

# Display UID and username of user executing the script
# Display if the user is the vagrant user or not


# Display the UID

echo "Your UID is ${UID}"


# Only display if the UID does NOT match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}."
  exit 1
fi


#Display the username
USER_NAME=$(id -un)

# Test if the command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo 'The id command didnot execute successfully.'
  exit 1
fi

echo "Your username is ${USER_NAME}."

# You can use a string test conditional
USERNAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USERNAME_TO_TEST_FOR}" ]]
then
  echo "Your username matches ${USERNAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${USERNAME_TO_TEST_FOR}" ]]
then
  echo "Your username does not match ${USERNAME_TO_TEST_FOR}."
  exit 1
fi

exit 0
