#!/usr/bin/env bash

# I've actually done a little different direction than the class script.

# displays various information to the screen

# Display 'Hello'
#echo 'Hello'

# Assign a value to a variable
if [ -z $1 ]; then
  NAME="World"
else
  NAME=$1
fi

# Display that value using the variable
echo "Hello ${NAME}!"


# another variable
VERB="script"
ENDING='ed'

echo "This is a ${VERB}${ENDING} output!"

# changing the ENDING variable
ENDING='able'
echo "This is a ${VERB}${ENDING} output!"

# change again...
ENDING='s'
echo "You are going to write many ${VERB}${ENDING} in this class!"

