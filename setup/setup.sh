#!/bin/bash

# Setup script for home

echo -n "Setup path? [~/.home]: "
read prompt_setup_path
SETUP_PATH="~/.home"
if ! [ "$prompt_setup_path" = "" ]; then
	$SETUP_PATH = "$PROMPT_SETUP_PATH"
fi

./.home/setup/bash.sh "$SETUP_PATH"

exit 0;