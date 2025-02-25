#############################  File Backup script ###################################
#Requirements:
#user needs to pass source and destination directories as arguments
#if both of them are not passed throw an error
#if directories are passed check if they actually exits? if not throw an error
#check if files are present in the directory
#if present zip the files
#delete the existing files
######################################################################################

#!/bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=14
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)

LOGFILE_DIR="/home/ec2-user/scripts"
LOGFILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1)
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

if [ $# -lt 2 ] # checking if user is passing both the arguments
then
    echo "Usage: <script_name> <source_dir> <dest_dir>"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
    echo "please check if directory exits"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo "please check if directory exits"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS) &>>$LOGFILE_NAME

if [ -n "$FILES" ]
then
    ZIP_FILE="$DEST_DIR/app-logs/$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ $ZIP_FILE &>>$LOGFILE_NAME
    if [ -f $ZIP_FILE ]
    then
        while read -r filepath;
        do
            echo "Deleting files" &>>$LOGFILE_NAME
            rm -rf $filepath
            echo "Deleted files" &>>$LOGFILE_NAME
        done <<< $FILES 
    else
        echo "could not zip the files"
else
    echo "No files exists older than $DAYS"
fi


