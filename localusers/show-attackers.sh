#!/usr/bin/env bash

# This script logs IP addresses from "attackers" and shows the number of their
# failed attempts if it exceeds "limit" of 10

LIMIT=10
FILE=${1}

# Make sure a file was supplied as an argument.
[[ ! -e ${FILE} ]] && (echo "Need to supply a filename as an argument." && exit 1)


# Display the CSV header.
clear
echo "Count,IP,Location"

# Loop through the list of failed attempts and corresponding IP addresses.
grep Failed ${FILE} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr |  while read COUNT IP
do
  # If the number of failed attempts is greater than the limit, display count, IP, and location.
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
    echo "${COUNT},${IP},${LOCATION}"
  fi
done
exit 0


