#!/bin/bash
FILE_NAME="/home/ec2-user/shell-scripting/sample.txt"
while IFS=$' \t\n' read -r word;
do
    echo "word: $word"
done < "$FILE_NAME"