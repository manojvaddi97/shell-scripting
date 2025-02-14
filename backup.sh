#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if user is not providing no of days then default is 14.
LOGFILE_DIR="/home/ec2-user/app_logs"
LOGFILE=$(echo $0 | cut -d "." -f1)
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
echo "Files are: $FILES"