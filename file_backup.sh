#!/bin/bash

#source; destination; daterange; copy; delete

SOURCE="/home/ec2-user/app_logs"
DESTINATION="/home/ec2-user/app_logs_bkp"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOGFILE_DIR="/home/ec2-user/scripts"
LOGFILE=$(echo $0 | awk -F "/" '{print $NF}' | cut -d "." -f1 )
LOGFILE_NAME="$LOGFILE_DIR/$LOGFILE-$TIMESTAMP.log"

mkdir -p $DESTINATION/$TIMESTAMP
FILES= find $SOURCE -name "*.log" -mtime +14
cp -r $FILES $DESTINATION/$TIMESTAMP
gzip $DESTINATION/$TIMESTAMP
echo "Backup completed on $TIMESTAMP"