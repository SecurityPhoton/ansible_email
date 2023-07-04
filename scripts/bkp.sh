#!/bin/bash

# Set variables
DESTINATION_SERVER="1.2.3.4"
SOURCE_DIR="/home/data"
DESTINATION_DIR=$1
SSH_USER="bkpuser"

# Create destination directory if it doesn't exist
ssh -p 22873 -i /root/.ssh/id_rsa $SSH_USER@$DESTINATION_SERVER "mkdir -p $DESTINATION_DIR"

# Use rsync to copy files incrementally
rsync -avz --exclude '/log/clamav/*'  -e "ssh -p 22873 -i /root/.ssh/id_rsa" $SOURCE_DIR/ $SSH_USER@$DESTINATION_SERVER:$DESTINATION_DIR/

FILE=/var/log/myrsync.log
if test -f "$FILE"; then
        echo "$FILE exists."
else
        touch /var/log/myrsync.log
fi

# Check if rsync was successful
if [ $? -eq 0 ]; then
        # Send  log report if all is OK
        echo "[" $(date) "] Rsync command successful" >> /var/log/myrsync.log
else
        # Send log if rsync failed
        echo "[" $(date) "] Rsync command failed" >> /var/log/myrsync.log
fi
