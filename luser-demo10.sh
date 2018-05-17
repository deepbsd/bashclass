#!/usr/bin/env bash

log() {
    # this function sends a message to syslog/messages and to STDOUT if VERBOSE is true
    # this function listens for global $VERBOSE; local $MESSAGE has a default value
    local MESSAGE=${@:-"You called the log function"}
    [[ "${VERBOSE}" = 'true' ]] && echo "${MESSAGE}"

    logger -t [luser-demo10.sh] "${MESSAGE}"

}


backup_file(){
    # this function creates a backup file. Returns non-zero status on error.
    [[ -f "${1}" ]] && local FILE="${1}" || return 1
    [[ -f "${FILE}" ]] && local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log  "Backing up ${FILE} to ${BACKUP_FILE}."
    
    # exit status of the function will be the exit status of the cp command
    cp -p ${FILE} ${BACKUP_FILE} && return 0

}


###------------- main ------------------#

# log practice
readonly VERBOSE='true'   # CONSTANT variable
log  "Hello World! Gonna do backups!"
log  "Are we having fun yet?"
log 

# do the backup
backup_file hello.sh

# Notify user whether backup_file() succeeded or failed:
# exit 0 if succeeded or exit 1 if fail
if [[ "${?}" -eq '0' ]]
then
    log 'File backup succeeded!'
else
    log 'File backup failed!'
    exit 1
fi


