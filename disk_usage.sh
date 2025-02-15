#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r usage;
do
    USAGE=$(echo $usage | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $usage | awk -F " " '{print $NF}')
    #echo "partition: $PARTITION usage is $USAGE"
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High Disk usage on Partition: $PARTITION Usage is: $USAGE \n "
    fi
done <<< $DISK_USAGE

echo -e "Message is $MSG"
echo "$MSG | mutt -s "High Disk Usage" iam.manoj497@gmail.com