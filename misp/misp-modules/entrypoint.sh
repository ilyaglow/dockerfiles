#!/bin/sh

REDIS_DEFAULT_HOST=redis

if [ $REDIS_HOST ]; then
    sed -i "s/hostname = '127.0.0.1'/hostname = '${REDIS_HOST}'/" /misp-modules/misp_modules/helpers/cache.py
else
    sed -i "s/hostname = '127.0.0.1'/hostname = '${REDIS_DEFAULT_HOST}'/" /misp-modules/misp_modules/helpers/cache.py
fi

if [ $REDIS_PORT ]; then
    sed -i "s/port = 6379/port = '${REDIS_PORT}'/" /misp-modules/misp_modules/helpers/cache.py
fi

if [ $REDIS_DB ]; then
    sed -i "s/db = 5/db = '${REDIS_DB}'/" /misp-modules/misp_modules/helpers/cache.py
fi

misp-modules -l '0.0.0.0'
