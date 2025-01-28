#!/bin/bash
echo "ALL variables passes : $@"
echo "number of variables : @#"
echo "script name : $0"
echo "present working directory: $PWD"
echo "hoe directory of current user: $HOME"
echo "which user is running this script: $USER"
echo "process id of current script: $$"
sleep 60 &
echo "process id of last command in background : $!"