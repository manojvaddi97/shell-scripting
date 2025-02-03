#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "ERROR: you need sudo privileges to perform this action"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 Failed"
        exit 1
    else
        echo "$2 Successfull"
    fi

}
dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $1 "MYSQL Installation"
else
    echo "MYSQL Installation already exits"
fi


dnf list installed git
if [ $? -ne 0 ]
then
    VALIDATE $1 "GIT Installation"
else
    echo "GIT Installation already exists"
fi