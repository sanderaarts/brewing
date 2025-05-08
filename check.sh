#!/bin/sh

# config
DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}")")
INTERVAL=$DIR/.interval
LAST_RUN=$DIR/.last-run

if [ -f $INTERVAL ]; then
  read MIN_INTERVAL_HOURS < $INTERVAL
else
  MIN_INTERVAL_HOURS=24
fi
if [ -f $LAST_RUN ]; then
  read THEN < $LAST_RUN
else
  THEN=0
fi
NOW=$(date +%s)

# Alway update last run timestamp to minimize changes that multiple shells will run the check in parallel
echo $NOW > $LAST_RUN

if [ $(( (NOW - THEN) / 3600 )) -ge $MIN_INTERVAL_HOURS ]; then
  echo 'Running `brew upgrade --greedy --dry-run` to see if there any outdated packages.'
  echo 'If so, run:'
  echo '\nbrew upgrade --greedy\n'
  echo 'If a cask gives an error (unavailable/does not exist), then reinstall it: `brew reinstall FORMULA` or `brew reinstall --cask CASK`'
  brew upgrade --greedy --dry-run

  # Update last run's timestamp
  echo $NOW > $LAST_RUN
else
  # Restore original timestamp
  echo $THEN > $LAST_RUN
fi
