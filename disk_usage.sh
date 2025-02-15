#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=5

while read -r usage;
do
    USAGE=$(echo $usage | awk -F " " '{print $6F}')
    PARTITION=$(echo $usage | awk -F " " '{print $NF}')
    echo "partition: $PARTITION usage is $USAGE"
done <<< $DISK_USAGE