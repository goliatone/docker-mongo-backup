#!/bin/bash

echo "0 2 * * * ./backup.sh" | crontab -
exec cron -f