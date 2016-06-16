#!/bin/bash

get_date () {
    date +[%Y-%m-%d\ %H:%M:%S]
}

echo "$(get_date) MongoDB backup started..."

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUT=/mongobackup/backup-$TIMESTAMP.tar.gz

echo "$(get_date) [1/3] Runing mongodump..."
mongodump -h $MONGO_HOST -p $MONGO_PORT


echo "$(get_date) [2/3] Creating tar archive..."
tar -zcvf $OUT dump/
rm -rf dump/

#Respect the spaces between brackes and statement!!! MOFO
if [ "$S3_BUCKET" = false ] || [ "$AWS_ACCESS_KEY_ID" = false ] || [ "$AWS_SECRET_ACCESS_KEY" = false ];
then
    echo "$(get_date) [3/3] Skeeping upload to S3."
    echo "$(get_date) [3/3] If this is an error, ensure all AWS environment variables are set."
    echo "$(get_date) [3/3] S3_BUCKET=$S3_BUCKET"
    echo "$(get_date) [3/3] AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID"
    echo "$(get_date) [3/3] AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY"
else
    echo "$(get_date) [3/3] Uploading to S3..."
    /usr/local/bin/aws s3 cp $OUT s3://$S3_BUCKET/
fi

echo "$(get_date) Mongo backup complted"
