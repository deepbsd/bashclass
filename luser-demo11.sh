#!/usr/bin/env bash

# This script generates a random password
# This user can set the password length with -l and add a special character with -s
# Vebose mode can be enabled with -v

######################## Globals
PASSWORD=""
# Set a default password length
LENGTH=48
# Don't use special character by default
USE_SPECIAL_CHARACTER='false'

######################## Functions

usage(){
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo "Generate a random password."
    echo " -l    LENGTH Specify the password length."
    echo " -s    Append a special character to the password."
    echo " -v    Increase verbosity"
    exit 1
}


generate_password(){
    SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+=-' | fold -w1 | shuf | head -c1 )
    PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})
    # User may have selected a LENGTH.  Therefore, return one fewer character to allow for 
    # special character at end of password...
    [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]] && PASSWORD="${PASSWORD:1}${SPECIAL_CHARACTER}"
}


# Control verbose mode...
log(){
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}


######################### Main


# Process the command line options...
while getopts vl:s OPTION
do
    case ${OPTION} in
        v)
            VERBOSE='true'
            log 'Verbose mode on.'
            ;;
        l)
            LENGTH="${OPTARG}"
            ;;
        s)
            USE_SPECIAL_CHARACTER='true'
            ;;
        ?)
            usage
            ;;
    esac
done

############ Main

log 'Generating a password...'
generate_password
log 'Done.'
log "Your password is: "
echo ${PASSWORD}
exit 0


