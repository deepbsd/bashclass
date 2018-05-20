#!/usr/bin/env bash

# Backs up and deletes (or disables or expires) a user's account

#################### Global variables
WHOIAM=$(whoami)
ARCHIVE_DIR=archives
EXPIRE_USER="true"

####################  Helpful Functions

# Display help/usage function.
usage(){
    echo "Usage: ${0} [-dra] USER [USERN]..." 
    echo "Disable a local Linux account." 
    echo " -d    deletes rather than disables user account(s)." 
    echo " -r    removes home directory of account(s)." 
    echo " -a    creates an archive of home directory in /tmp/archive" 
    exit 1
}


# check uid of person running the script
check_uid(){
    USER_ID=$1
    if [[ "${USER_ID}" -ne 0 ]]
    then
        echo "Need to run as root." 
        exit 1
    fi
}


# check uid of account. Can't delete system accounts!
check_acct_id(){
	#echo "checking acct_id of $1"
    ACCT_ID=${1}
	[[ "${ACCT_ID}" -ge 1000 ]] || (echo "Cannot delete system accounts" && exit 1)

}


# only expires a user's account
expire_user(){
	#echo "called expire_user()"
    USER=$1
    echo "USER is ${USER}"
    chage -E 0 ${USER}
	[[ "${?}" -eq 0 ]] || (echo "Account could not be expired."  && exit 1)
}


# only disables a users account but doesn't delete his/her home directory
disable_user(){
	#echo "called disable_user()"
    USER=$1
    userdel ${USER}
	[[ "${?}" -eq 0 ]] || (echo "Account could not be disabled."  && exit 1)
    echo "Accounte ${USER} disabled."
}


# deletes a user from the system along with his/her home directory
delete_user(){
	#echo "called delete_user()"
    USER=$1
    userdel -r ${USER}
	[[ "${?}" -eq 0 ]] || (echo "Account could not be deleted."  && exit 1)
    echo "Account ${USER} deleted."
}


# create an archive of user's home directory
archive_user(){
	#echo "called archive_user()"
    USER=$1
    [[ -d "${ARCHIVE_DIR}" ]] || mkdir -p ${ARCHIVE_DIR}
    [[ ! -d "/home/${USER}" ]] && echo "${USER}'s home directory doesn't exist"  && exit 1
    [[ -d "/home/${USER}" ]] && tar cvPfz "${ARCHIVE_DIR}/${USER}.tar.gz" "/home/${USER}" &> /dev/null && echo "/home/${USER} directory archived."
    # exit with error if user directory could not be archived...
	[[ "${?}" -eq 0 ]] || (echo "Could not archive home directory for ${USER}!" && exit 1)
    echo "Account ${USER} archived at ${ARCHIVE_DIR}/${USER}."
}


##########################################
################   Main   ################
##########################################

check_uid $(id -u ${WHOIAM})    # exit 1 if not run as root.
[[ "${#}" -lt 1 ]] && usage     # must have some arguments


# Process the command line options...
while getopts dra OPTION
do
    case ${OPTION} in

        d) 
            EXPIRE_USER="false"
            DELETE_USER="false"
            DISABLE_USER="true"
            ;;
        r) 
            EXPIRE_USER="false"
            DISABLE_USER="false"
            DELETE_USER="true"
            ;;
        a) 
            ARCHIVE="true"
            ;;
        ?) 
            usage 
            ;;
    esac
done


# Remove the options while leaving remaining arguments (user(s) account(s))
shift "$(( OPTIND - 1 ))"


# Loop through users provided on command line
for USERNAME in "${@}"
do
    USER=${USERNAME}
    echo "Processing user: ${USER}"

    
    # Ensure UID of account is at least 1000--Don't delete system accounts
    USER_ID=$(id -u ${USER})
    check_acct_id "${USER_ID}"                   

    # Create an archive if requested to do so
    [[ "${ARCHIVE}" = "true" ]] && archive_user "${USER}"
    
    # Do we only expire the user?
    [[ "${EXPIRE_USER}" = 'true' ]] && expire_user "${USER}"

    # Do we only disable the user?
    [[ "${DISABLE_USER}" = 'true' ]] && disable_user "${USER}"

    # Do we delete user or not?
    [[ "${DELETE_USER}" = 'true' ]] && delete_user "${USER}"

    # this should be the end of our forloop for all users

done


# if we got this far, all users should have been processed successfully.
exit 0




