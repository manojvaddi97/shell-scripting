#!/bin/bash
set -x
FILE_NAME="/home/ec2-user/shell-scripting/sample.txt"
while read -r word;
do
    echo "word: $word"
done < "$FILE_NAME"