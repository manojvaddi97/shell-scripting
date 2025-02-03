#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
DIR="/var/log/shell_scripts"
LOGFILE=$(echo $0 | cut -d '.' -f1)
TIMESTAMP=$(date +"%m-%d-%Y-%H-%M-%S")
LOGFILE_NAME=$DIR/$LOGFILE-$TIMESTAMP
USERID=$(id -u)


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 $R Failed.... $N"
        exit 1
    # systemctl status mysql # checking status 
    # if [ $? -ne 0 ]
    # then
    #     exit 1
    else
        echo -e " $2 $G completed successfully $N"
    fi
}

if [ USERID -ne 0 ]
then
    echo "Error: user need to have sudo privileges"
    exit 1
fi

dnf list installed mysql  >>&LOGFILE_NAME # checking if mysql is previously installed or not?
if [ $? -ne 0 ] # checking if previous command output is successful or not?
then
    dnf install mysql -y >>&LOGFILE_NAME # installing mysql
    VALIDATE $1 "MYSQL Installation"
else
    echo -e "MYSQL is $Y already installed $N"
fi

################################### Installing GIT ############################################

dnf list installed git >>&LOGFILE_NAME # checking if git is previously installed
if [ $? -ne 0 ]
then
    dnf install git -y >>&LOGFILE_NAME # installing git
    VALIDATE $1 "GIT Installation"
else
    echo -e "Git is $Y already installed $N"
fi