###############################################################################
#requirements:
#file system to check disk usage
#threshold
################################################################################

#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5
MSG=""

while read -r output;
do
    USAGE=$(echo $output | awk -F " " '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $output | awk -F " " '{print $NF}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MSG+="High Disk utilization on partition: $PARTITION, usage is: $USAGE"
    fi
done <<< $DISK_USAGE
echo -e "Message is $MSG"