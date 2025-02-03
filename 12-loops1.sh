#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGFILE_DIR="/var/log/shell_scripts"
LOGFILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%m-%d-%Y-%H-%M-%S)
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

#check if the user is root
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "Error: user should have root privileges"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 is... Failed"
        exit 1
    else
        echo "$2 is... Successful"
    fi
}
#check if packages are already installed
dnf list installed $package &>>$LOGFILE_NAME
if [ $? -ne 0 ]
then
    for package in $@
    do
        dnf install $package -y &>>$LOGFILE_NAME
        VALIDATE $1 "$package Installation"
    done
    # dnf install mysql -y
    # if [ $? -ne 0 ]
    # VALIDATE $1 "MYSQL Installation"
else
    echo "$package Installation already exists"
fi