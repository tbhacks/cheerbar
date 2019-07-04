#!/bin/bash

trap "exit" INT

URL="http://api.thingspeak.com/channels/1417/field/2/last.txt"

OLDCOLOUR=""
while true; do
	# Get cheerlights colour
	HEXCOLOUR=$(curl "$URL" 2> /dev/null)

	# Check format
	if [[ ! $HEXCOLOUR =~ ^#[0-9a-fA-F]{6} ]]; then
		echo "Something has gone wrong while retrieving the colour."
		exit 1
	fi

	if [[ ! $HEXCOLOUR == $OLDCOLOUR ]]; then
		echo "Setting Light Bar to $HEXCOLOUR"
		OLDCOLOUR=$HEXCOLOUR
		
		# FIXME Currently requires sudo to set colour
		sudo ./barset.sh $HEXCOLOUR
	fi

	sleep 10
done
