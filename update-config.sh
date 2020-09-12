#!/bin/bash
CONFIG_FILE=$1
TARGET_KEY=$2
REPLACEMENT_VALUE=$3

# Just in case config file doesn't exist yet.
touch "$CONFIG_FILE"

# Search for key in file.
if grep -Fq "$TARGET_KEY" "$CONFIG_FILE"
then
  #echo "Replacing $2 with $3 in $1"
  # Key exists, replace it.
  sed -i "s|\($TARGET_KEY *= *\).*|\1$REPLACEMENT_VALUE|" "$CONFIG_FILE"
else
  #echo "Adding $2 with $3 in $1"
  # Key does not exist, append it.
  echo "$TARGET_KEY=$REPLACEMENT_VALUE" >> "$CONFIG_FILE"
fi