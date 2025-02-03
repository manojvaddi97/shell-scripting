#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo "ERROR: you need sudo privileges to perform this action"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R Failed $N"
        exit 1
    else
        echo -e "$2 $G Successfull $N"
    fi

}
dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $1 "MYSQL Installation"
else
    echo -e "MYSQL Installation $Y already exits $N"
fi


dnf list installed git
if [ $? -ne 0 ]
then
    VALIDATE $1 "GIT Installation"
else
    echo -e "GIT Installation $Y already exists $N"
fi