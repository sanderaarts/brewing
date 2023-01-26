#!/bin/sh

# config
MIN_INTERVAL_HOURS=12
LAST_RUN_FILE=$(dirname -- "$(readlink -f "${BASH_SOURCE}")")/.last-run

if [ -f $LAST_RUN_FILE ]; then
  read THEN < $LAST_RUN_FILE
else
  THEN=0
fi
NOW=$(date +%s)

# Alway update last run timestamp to minimize changes that multiple shells will run the check in parallel
echo $NOW > $LAST_RUN_FILE

if [ $(( (NOW - THEN) / 3600 )) -gt $MIN_INTERVAL_HOURS ]; then
  echo "\nbrew upgrade --greedy\n"
  brew upgrade --greedy --dry-run
  #echo $NOW > $LAST_RUN_FILE
else
  # Restore original timestamp
  echo $THEN > $LAST_RUN_FILE
fi
