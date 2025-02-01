#!/bin/bash

USERID=$(id -u) # checking id of the user
if [ $USERID -ne 0] # condition that checks if user id is root user or not?
then
    echo "Error: You need sudo privileges to install the software"
    exit 1
fi

###########################Install MYSQL#####################################

dnf list installed mysql # checking if mysql is previously installed or not?
if [ $? -ne 0] # checking if previous command output is successful or not?
then
    dnf install mysql -y # installing mysql
    if [ $? -ne 0 ]
    then
        exit 1
    systemctl status mysql # checking status 
    if [ $? -ne 0 ]
    then
        exit 1
    else
        echo "MYSQL is successfully installed"
else
    echo "MYSQL is already installed"
fi

################################### Installing GIT ############################################

dnf list installed git # checking if git is previously installed
if [ $? -ne 0 ]
then
    dnf install git -y # installing git
    if [ $? -ne 0 ]
    then
        exit 1
    systemctl status git # checking status
    if [ $? -ne 0 ]
    then
        exit 1
    else
        echo "Git is successfully installed"
else
    echo "Git is already installed"
fi