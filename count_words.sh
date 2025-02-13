#!/bin/bash
FILE_NAME="/home/ec2-user/shell-scripting/sample.txt"
while  read -r word;
do
    echo "word: $word"
    wc -l $word
    
done < <(tr -s '[:space:]' '\n' < "$FILE_NAME")