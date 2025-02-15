#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)

while read -r usage;
do
    echo "$usage"
done <<<$DISK_USAGE