#!/bin/bash

R="\e[30m"
G="\e[31m"
Y="\e[32m"
N="e\[0m"

SOURCE_DIR="/home/ec2-user/app_logs"
DEST_DIR="/home/ec2-user/archives"
DAYS=${3:-14}
LOGFILE_DIR="/home/ec2-user/app_logs"
TIMESTAMP=$(date +%m-%d-%Y-%H-%M-%S)
LOGFILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1)
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

USAGE(){
    echo -e "$R USAGE:: $N sh backup.sh <source_dir> <dest_dir> <days>"
    exit 1
}

if [ $# -lt 2 ] # check if the arguements passed by user are less than 2
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ] # checks if source directory doesn't exits
then
    echo -e "$R Error: $N please check if directory exists"
    exit 1
fi

if [ ! -d $DEST_DIR ] # checks if dest directory doesn't exists
then
    echo -e "$R Error: $N please check if directory exists"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -f "$FILES" ]
then
    echo "Files are : $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ $ZIP_FILE
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "$G Succesfully created zipfiles $N"
        while read -r filepath;
        do
            echo -e "Deleting files: $filepath"
            rm -rf $filepath
            echo -e "Deleted files: $filepath"
        done <<< $FILES
    else
        echo -e "$R Error: $N Could not zip the files"
    fi


else
    echo -e "No files found older than $DAYS"
fi