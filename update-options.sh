#!/bin/bash

BASE_CONFIG_DIR=$1
APPLICATION=$2
CONFIG_FILE=$3

# Create etc directory if non-existent.
if [ ! -d "/etc/$APPLICATION" ]; then
  mkdir "/etc/$APPLICATION"
fi
echo "Updating ${APPLICATION}'s ${CONFIG_FILE} configuration options, from ${BASE_CONFIG_DIR} directory..."

# Read each file in the configmap path.
for option_path in "${BASE_CONFIG_DIR}/${APPLICATION}/${CONFIG_FILE}"/*
do
  option="$(basename "$option_path")"
  value=$(<"${option_path}")
  #echo "Found option: ${option} with value ${value}"

  # Update key-value pair in config file.
  ./update-config.sh "/etc/$APPLICATION/$CONFIG_FILE" "$option" "$value"
done
echo "Done..."
