#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then
    echo "ERROR: you need sudo privileges to perform this action"
    exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "MYSQL Installation Failed"
        exit 1
    else
        echo "MYSQL Installation Successfull"
    fi
else
    echo "MYSQL Installation already exits"
fi


dnf list installed git
if [ $? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "GIT Installation Failed"
        exit 1
    else
        echo "GIT Installation Successfull"
    fi
else
    echo "GIT Installation already exists"
fi