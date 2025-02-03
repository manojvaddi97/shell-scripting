#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGFILE_DIR="/var/log/shell_scripts"
LOGFILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%m-%d-%Y-%H-%M-%S)
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

if [ $USERID -ne 0 ]
then
    echo "ERROR: you need sudo privileges to perform this action"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2... $R Failed $N"
        exit 1
    else
        echo -e "$2... $G Successfull $N"
    fi

}

for package in $@
do
    dnf list installed $package
    if [ $? -ne 0 ]
    then
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is $Y already Installed $N"


done