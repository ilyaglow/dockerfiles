#!/bin/sh

/echoip --reverse-lookup --trusted-header="${TRUSTED_HEADER}" --country-db="${GEOCOUNTRY_PATH}" --city-db="${GEOCITY_PATH}"
