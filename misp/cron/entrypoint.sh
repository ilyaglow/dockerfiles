#!/bin/sh
FETCH_ROUTE=/feeds/fetchFromAllFeeds
DEFAULT_MISP_URL=http://misp
# Update once an hour
DEFAULT_CRON_TIME="0 */1 * * *"

if [ ! "$MISP_URL" ]; then
    MISP_URL=$DEFAULT_MISP_URL
fi

DEFAULT_CRON_CMD="curl -H 'Authorization: $MISP_AUTH' -H 'Accept: application/json' -H 'Content-Type: application/json' ${MISP_URL}${FETCH_ROUTE}"

if [ ! "$CRON_TIME" ]; then
    CRON_TIME=$DEFAULT_CRON_TIME
fi

if [ ! "$CRON_CMD" ]; then
    CRON_CMD=$DEFAULT_CRON_CMD
fi

crontab -d \
  && echo "${CRON_TIME} ${CRON_CMD}" | crontab - \
  && crond -f -L /dev/stdout
