#!/usr/bin/env bash

# This script creates an account on the local system
# You will be prompted for the account name and password.


# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask the for real name
read -p 'Enter the name of the person who this account is for: ' COMMENT


# Ask for the password.
read -p 'Enter the password: ' PASSWORD


# Create the user account
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for this user 
echo ${PASSWORD} | passwd --stdin ${USER_NAME}


# Force password change on first login.
passwd -e ${USER_NAME}



