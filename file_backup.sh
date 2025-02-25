#!/bin/bash

#source; destination; daterange; copy; delete

SOURCE=$1 #pass source folder
DESTINATION=$2 # pass destination folder
DAYS=14
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE_DIR="/home/ec2-user/scripts"
LOGFILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1 )
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

if [ $# -lt 2 ] # comparing if no of arguments passed are less than 2
then
    echo "Usage: <script_name> <source_dir> <dest_dir>"
    exit 1
fi

if [ ! -d $SOURCE ] #checking if source directory doesn't exits
then
    echo "Error: please check if directory exists"
    exit 1
fi

if [ ! -d $DESTINATION ] # checking if destination directory doesn't exits
then
    echo "Error: please check if directory exists"
    exit 1
fi

FILES=$(find $SOURCE -name "*.log" -mtime +$DAYS) # find the files older than 14 days

if [ -n "$FILES" ] # checking if files are present
then
    echo "Files are: $FILES"
    ZIP_FILE="$DESTINATION/app-logs-$TIMESTAMP.zip" # creating zipfile indestination folder
    find $SOURCE -name "*.log" -mtime +$DAYS | zip -@ $ZIP_FILE #ziping the files
    if [ -f "$ZIP_FILE" ] # if zip files exists
    then
        echo "Successfully created zip files"
        while read -r filepath; # read the files
        do
            echo "Deleting files: $filepath"
            rm -rf $filepath # delete the files
            echo "Deleted files: $filepath"
        done <<< $FILES
    else
        echo "could not zip the files"
    fi
else
    echo "No files foumd older than $DAYS"
fi