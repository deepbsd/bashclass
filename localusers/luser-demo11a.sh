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
# Create the array of all arguments for use inside functions
declare -a ALL_ARGUMENTS
ALL_ARGUMENTS=(${@})
NUMBER_OF_ARGUMENTS=${#}

######################## Functions

usage(){
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo "Generate a random password."
    echo " -l    LENGTH Specify the password length."
    echo " -s    Append a special character to the password."
    echo " -v    Increase verbosity"
    exit 1
}

display_commandline_options(){
	# Inspect OPTIND  -- $OPTIND is number of CLine arguments processed by GETOPTS
	# I wanted to experiment with slices of an array here...
	echo "OPTIND: ${OPTIND}"
	echo "Number of args: ${NUMBER_OF_ARGUMENTS}"
	echo "All args: ${ALL_ARGUMENTS[*]}"
	echo "First arg ${ALL_ARGUMENTS[0]}"
	echo "Second arg: ${ALL_ARGUMENTS[1]}"
	echo "Third arg: ${ALL_ARGUMENTS[2]}"
}

remove_commandline_options(){
	# Remove the options while leaving the remaining arguments
	shift "$((OPTIND-1))"
	echo "Number of args: ${#}"
	echo "All args: ${@}"
	echo "First arg ${1}"
	echo "Second arg: ${2}"
	echo "Third arg: ${3}"
}

shift_commandline_options(){
	# show commandline options before and after shifting them out...
	echo "Before shifting CL options out..."
	display_commandline_options
	echo "After shifting CL options out..."
	remove_commandline_options ${ALL_ARGUMENTS[*]}
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


############ Main (...continued)

#shift_commandline_options   # compare CL options before & after shift
remove_commandline_options && [[ "${#}" -gt 0 ]] && usage
log 'Generating a password...'
generate_password
log 'Done.'
log "Your ${LENGTH}-character password is: "
echo ${PASSWORD}
exit 0


