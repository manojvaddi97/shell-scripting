#!/bin/bash
FILE_NAME="/home/ec2-user/shell-scripting/sample.txt"
IFS=$' \t\n'
while read -r words
do
    echo "word: $words"
done < "$FILE_NAME"