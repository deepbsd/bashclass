#!/usr/bin/env bash

# Display the top three most visited web server's logfile

LOG_FILE="${1}"

[[ -e "${LOG_FILE}" ]] || ( echo "Cannot open ${LOG_FILE}!" >&2 && exit 1 )

cut -d '"' -f 2 ${LOG_FILE} | cut -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3



