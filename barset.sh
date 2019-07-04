#!/bin/bash

# Partially derived from https://gaming.stackexchange.com/questions/336934/how-to-set-default-color-and-brightness-of-leds-of-the-dualshock-4-controller-on

# Assume DS4 is connected as js0
DSPATH=$(udevadm info -q path -n /dev/input/js0)

# Extract LED Path
LED=$(echo "$DSPATH" | sed -n 's|.*/\([[:xdigit:]]\{4\}:[[:xdigit:]]\{4\}:[[:xdigit:]]\{4\}\.[[:xdigit:]]\{4\}\).*|\1|gp')
LEDPATH=/sys/class/leds/$LED

# Check format
if [[ ! $1 =~ ^#[0-9a-fA-F]{6} ]]; then
	echo "Something has gone wrong while retrieving the colour."
	exit 1
fi

# Extract RGB converting from hexadecimal.
RED="${1:1:2}"
RED=$(( 16#$RED ))

GREEN="${1:3:2}"
GREEN=$(( 16#$GREEN ))

BLUE="${1:5:2}"
BLUE=$(( 16#$BLUE ))

# Write
echo $RED > $LEDPATH:red/brightness
echo $GREEN > $LEDPATH:green/brightness
echo $BLUE > $LEDPATH:blue/brightness
