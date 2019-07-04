#!/bin/bash

trap "exit" INT

URL="http://api.thingspeak.com/channels/1417/field/2/last.txt"

while true; do
	# Get cheerlights colour
	HEXCOLOUR=$(curl "$URL" 2> /dev/null)

	# Check format
	if [[ ! $HEXCOLOUR =~ ^#[0-9a-fA-F]{6} ]]; then
		echo "Something has gone wrong while retrieving the colour."
		exit 1
	fi

	# Extract RGB converting from hexadecimal.
	RED="${HEXCOLOUR:1:2}"
	RED=$(( 16#$RED ))

	GREEN="${HEXCOLOUR:3:2}"
	GREEN=$(( 16#$GREEN ))

	BLUE="${HEXCOLOUR:5:2}"
	BLUE=$(( 16#$BLUE ))

	echo "$RED $GREEN $BLUE"
	sleep 10
done
