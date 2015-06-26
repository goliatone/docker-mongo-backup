#!/bin/bash

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
mongodump -h Mongo
tar -zcvf "/mongobackup/backup-$TIMESTAMP.tar.gz" dump/
rm -rf dump/
