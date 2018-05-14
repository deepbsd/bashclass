#!/usr/bin/env bash

# This script demonstrates I/O redirection

#Redirect STDOUT to a file
FILE="/tmp/data"

head -n1 /etc/passwd > "${FILE}"


# Redirect STDIN to a program
read LINE < ${FILE}
echo "Line contains: ${LINE}"


# Redirect STDOUT to a file, overwriting that file
head -n3 /etc/passwd > "${FILE}"
echo
echo "Contents of ${FILE} is:"
cat ${FILE}


# Redirect random output to a file, appending to that file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}: "
cat ${FILE}

# Redirect STDIN to a program, using FD 0
read LINE 0< ${FILE}
echo
echo "LINE contains: ${LINE}"


# Redirect STDOUT to a file using FD 1, overwritinig the file.
head -n3 /etc/passwd 1> ${FILE}
echo 
echo "Contents of ${FILE}: "
echo "====================="
cat ${FILE}

# Redirect STDERR to a file using FD2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

echo
echo "Contents of ${ERR_FILE}: "
echo "=========================="
cat ${ERR_FILE}
echo

# Redirect STDOUT and STDERR to a file using New Syntax
# Note: &> combines redirection of both FD1 and FD2 (STDOUT and STDERR) together
head -n3 /etc/passwd /fakefile &> ${FILE}
echo 
echo "Contents of ${FILE} now is: "
echo "==========================="
cat ${FILE}


# Redirect STDOUT and STDERR through a pipe to `cat` with line numbers.
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
echo "This is STDERR!" >&2


# Discard STDOUT
echo 
echo "Discarding STDOUT: "
head -n3 /etc/passwd /fakefile > /dev/null

# Discard STDERR
echo 
echo "Discarding STDERR: "
head -n3 /etc/passwd /fakefile 2> /dev/null

# Discard both STDOUT and STDERR
echo
echo "Discarding both STDOUT and STDERR together..."
head -n3 /detc/passwd /fakefile &> /dev/null

# Clean up files we created...
rm ${FILE} ${ERR_FILE} &> /dev/null



