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
  echo 'Running `brew upgrade --greedy --dry-run` to see if there any outdated packages.'
  echo 'If so, run:'
  echo '\nbrew upgrade --greedy\n'
  echo 'If a cask gives an error (unavailable/does not exist), then reinstall it: `brew reinstall FORMULA` or `brew reinstall --cask CASK`'
  brew upgrade --greedy --dry-run

  # Update last run's timestamp
  echo $NOW > $LAST_RUN_FILE
else
  # Restore original timestamp
  echo $THEN > $LAST_RUN_FILE
fi
