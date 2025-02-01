#!/bin/bash

USERID=$(id -u)
if [ USERID -ne 0 ]
then
    echo "Error: user need to have sudo privileges"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 Failed...."
        exit 1
    # systemctl status mysql # checking status 
    # if [ $? -ne 0 ]
    # then
    #     exit 1
    else
        echo " $2 completed successfully"
    fi
}

dnf list installed mysql # checking if mysql is previously installed or not?
if [ $? -ne 0 ] # checking if previous command output is successful or not?
then
    dnf install mysql -y # installing mysql
    VALIDATE $1 "MYSQL Installation"
else
    echo "MYSQL is already installed"
fi

################################### Installing GIT ############################################

dnf list installed git # checking if git is previously installed
if [ $? -ne 0 ]
then
    dnf install git -y # installing git
    VALIDATE $1 "GIT Installation"
else
    echo "Git is already installed"
fi