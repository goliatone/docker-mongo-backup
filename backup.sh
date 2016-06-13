#!/bin/bash

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
mongodump -h $MONGO_HOST -p $MONGO_PORT
# mongodump -h mongo
tar -zcvf "/mongobackup/backup-$TIMESTAMP.tar.gz" dump/
rm -rf dump/
