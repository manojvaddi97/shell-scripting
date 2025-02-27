#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if user is not providing no of days then default is 14.
LOGFILE_DIR="/home/ec2-user/app_logs"
LOGFILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1)
TIMESTAMP=$(date +%m-%d-%Y-%H-%M-%S)
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is... $R Failed $N"
        exit 1
    else
        echo "$2 is... $G Successful $N"
    fi
}

USAGE(){
    echo -e "$R USAGE:: sh backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>"
    exit 1
}
if [ $# -lt 2 ]
then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R $SOURCE_DIR does not exit.. please check"
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R $DEST_DIR does not exit.. please check"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ]
then
    echo "Files are: $FILES"
    ZIP_FILE=$DEST_DIR/app-logs-$TIMESTAMP.zip
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS| zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "$G Succesfully created zip file $N"
        while read -r filepath
        do
            echo "Deleting files: $filepath"
            rm -rf $filepath
            echo "Deleted files: $filepath"
        done <<< $FILES
    else
        echo -e "$R Error: $N could not create zip file"
    fi
else
    echo "No files found older than $DAYS"
fi