#!/bin/bash

CRON_SCHEDULE=${CRON_SCHEDULE:-0 2 * * *}
CRON_CLEANUP=${CRON_CLEANUP:-0 5 1 * *}

CRON_ENVIRONMENT="
MONGO_HOST=${MONGO_HOST:-mongo}
MONGO_PORT=${MONGO_PORT:-27017}
S3_BUCKET=${S3_BUCKET:-false}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-false}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:-false}
"

CRON_COMMAND="/backup.sh 1>/var/log/backup_script.log 2>&1"

echo "Start mongobackup script..."
echo
echo "CRON_SCHEDULE"
echo "$CRON_SCHEDULE"
echo
echo "CRON_ENVIRONMENT"
echo "$CRON_ENVIRONMENT"

touch tmpcron
echo "$CRON_ENVIRONMENT$CRON_SCHEDULE $CRON_COMMAND" >> tmpcron
echo "$CRON_CLEANUP /remove.sh" >> tmpcron
crontab tmpcron
rm tmpcron

cron start -f
tail -f /var/log/backup_script.log
